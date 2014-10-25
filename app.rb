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
    def signed_in?
      session[:user] ? true : false
    end

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
    if signed_in?
      cache = SimpleCache.load('timeline')
      if cache
        @tweets = cache
      else
        twitter = create_twitter_client
        @tweets = twitter.home_timeline
        SimpleCache.save(@tweets, 'timeline')
      end
      erb :home
    else
      erb :index
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
    SimpleCache.delete_all
    redirect to('/')
  end

  get '/logout' do
    session[:user] = nil
    SimpleCache.delete_all
    redirect to('/')
  end
end

class SimpleCache
  CACHE_PATH_BASE = 'tmp/cache'

  def self.save(object, name)
    FileUtils.mkdir_p(CACHE_PATH_BASE) unless Dir.exist?(CACHE_PATH_BASE)
    File.open(cache_path(name), 'wb') do |f|
      f.write(Marshal.dump(object))
    end
  end

  def self.load(name)
    file = cache_path(name)
    return nil unless File.exist?(file)
    Marshal.load(File.binread(file))
  end

  def self.delete(name)
    file = cache_path(name)
    File.delete(file) if File.exist?(file)
  end

  def self.delete_all
    FileUtils.rm_rf(CACHE_PATH_BASE)
  end

  private
  def self.cache_path(name)
    File.join(CACHE_PATH_BASE, name)
  end
end
