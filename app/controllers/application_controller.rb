require "rack-flash"
class ApplicationController < Sinatra::Base
  use Rack::Flash
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  enable :sessions
  set :views, Proc.new { File.join(root, "../views/") }


  get '/' do
    erb :index
  end
end