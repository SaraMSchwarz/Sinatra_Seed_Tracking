require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
      set :public_folder, 'public'
      set :views, 'app/views'
      enable :sessions
      set :session_secret, 'secret'
  end

  get "/" do
    redirect to :"/login" unless logged_in?
    erb :index
  end

  get "/login" do
    erb :login
  end

  get "/logout" do
    session.destroy
    redirect to :"/"
  end

  post "/login" do
    user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
    end
    redirect to :"/"
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end

end
