class UserController < ApplicationController

  get '/signup' do
    if is_logged_in?
      flash[:notice] = "Welcome back!"
      redirect to '/seeds'
    else
      erb :'user/create_user'
    end
  end

  post '/signup' do
    if is_logged_in?
      flash[:notice] = "Welcome back!"
      redirect to '/seeds'
    elsif params[:username] == "" || params[:password] == ""
      flash[:notice] = "Please sign up by creating a username and a password."
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/seeds'
    end
  end

  get '/login' do
    if is_logged_in?
      flash[:notice] = "Welcome back!"
      redirect '/seeds'
    else
      erb :'user/login'
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/seeds"
    else
      flash[:notice] = "Hmm, your username or password was not correct. Please try again."
      redirect "/login"
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      flash[:notice] = "Come back soon!"
      redirect '/login'
    else
      redirect '/'
    end
  end
end
