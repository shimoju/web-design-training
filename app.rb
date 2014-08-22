require 'sinatra/base'
require 'sinatra/reloader'

class App < Sinatra::Base
  configure do
    enable :sessions
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end
end
