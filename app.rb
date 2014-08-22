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
    erb :index
  end
end
