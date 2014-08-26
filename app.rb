require 'sinatra/base'
require 'sinatra/reloader'
require 'omniauth-twitter'
require 'twitter'

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
    if session[:user]
      twitter = create_twitter_client
      @tweets = twitter.home_timeline
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
    redirect to('/')
  end

  get '/logout' do
    session[:user] = nil
    redirect to('/')
  end
end
