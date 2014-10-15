ENV['RACK_ENV'] ||= 'development'
require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

class App < Sinatra::Base
  configure do
    enable :sessions

    twitter_api_key = ENV['TWITTER_API_KEY']
    twitter_api_secret = ENV['TWITTER_API_SECRET']
    set twitter_api_key: twitter_api_key, twitter_api_secret: twitter_api_secret

    use OmniAuth::Builder do
      provider :twitter, twitter_api_key, twitter_api_secret
    end
  end

  configure :development do
    set :session_secret, 'b2df5a814269e76c41714ff203bede4724e52892c066a8f3f90310d6047d9b1e2903beb49f45c10c70dd1c5c517b54779ef9a0b940a55e6f33e97d1ea3340a1f'
    require 'sinatra/reloader'
    register Sinatra::Reloader
  end

  helpers do
    def create_twitter_client
      Twitter::REST::Client.new do |config|
        config.consumer_key = settings.twitter_api_key
        config.consumer_secret = settings.twitter_api_secret
        config.access_token = session[:user][:token]
        config.access_token_secret = session[:user][:secret]
      end
    end
  end

  get '/' do
    unless session[:user]
      erb :index
    else
      cache = SimpleCache.load
      if cache
        @tweets = cache
      else
        twitter = create_twitter_client
        @tweets = twitter.home_timeline
        SimpleCache.save(@tweets)
      end
      erb :home
    end
  end

  get '/auth/:provider/callback' do
    auth = request.env['omniauth.auth']
    session[:user] = {
      name: auth.info.name,
      username: auth.info.nickname,
      image: auth.info.image,
      token: auth.credentials.token,
      secret: auth.credentials.secret
    }
    SimpleCache.delete
    redirect to('/')
  end

  get '/logout' do
    session[:user] = nil
    SimpleCache.delete
    redirect to('/')
  end
end

class SimpleCache
  def self.save(object)
    Dir.mkdir('tmp') unless Dir.exist?('tmp')
    File.open('tmp/cache', 'wb') do |f|
      f.write(Marshal.dump(object))
    end
  end

  def self.load
    return nil unless File.exist?('tmp/cache')
    Marshal.load(File.binread('tmp/cache'))
  end

  def self.delete
    File.delete('tmp/cache') if File.exist?('tmp/cache')
  end
end
