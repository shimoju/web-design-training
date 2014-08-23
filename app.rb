require 'sinatra/base'
require 'sinatra/reloader'
require 'omniauth-twitter'

class App < Sinatra::Base
  configure do
    enable :sessions

    use OmniAuth::Builder do
      provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']
    end
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    if session[:user]
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
