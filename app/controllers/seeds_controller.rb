class SeedController < ApplicationController

  get '/seeds/new' do
    if is_logged_in?
      erb :'seeds/new'
    else
      flash[:notice] = "You need to log in first."
      redirect to '/login'
    end
  end

  post '/seeds' do
    if params[:seed_name] == "" || params[:seed_category] == ""
      flash[:notice] = "Oops! Seeds must have a name and a category."
      redirect to '/seeds/new'
    else
      user = current_user
      @seed = Seed.create(
        :seed_name => params[:seed_name],
        :seed_category => params[:seed_category],
        :seed_variety => params[:seed_variety],
        :seed_brand => params[:seed_brand],
        :seed_quantity => params[:seed_quantity],
        :seed_notes => params[:seed_notes],
        :user_id => user.id)
      redirect to "/seeds/#{@seed.id}"
    end
  end

  get '/seeds' do
    if is_logged_in?
      @user = current_user
      @seeds = @user.seeds.all
      erb :'seeds/index'
    else
      flash[:notice] = "Looks like you weren't logged in yet. Please log in below."
      redirect to '/login'
    end
  end

  get '/seeds/:id' do
    if is_logged_in?
      @seed = Seed.find_by_id(params[:id])
      if @seed.user_id == session[:user_id]
        erb :'seeds/show'
      else
        flash[:notice] = "These are not your seeds."
        redirect to '/seeds'
      end
    else
      flash[:notice] = "Looks like you weren't logged in yet. Please log in below."
      redirect to '/login'
    end
  end

  get '/seeds/:id/edit' do
    if is_logged_in?
      @seed = Seed.find_by_id(params[:id])
      if @seed.user_id == session[:user_id]
        erb :'seeds/edit'
      else
        flash[:notice] = "These are not your seeds."
        redirect to '/seeds'
      end
    else
      flash[:notice] = "Looks like you weren't logged in yet. Please log in below."
      redirect to '/login'
    end
  end

  patch '/seeds/:id' do
    if params[:seed_name] == "" || params[:seed_category] == ""
      flash[:notice] = "Oops! Seeds must have a name and a category."
      redirect to "/seeds/#{params[:id]}/edit"
    else
      user = current_user
      @seed = Seed.create(
        :seed_name => params[:seed_name],
        :seed_category => params[:seed_category],
        :seed_variety => params[:seed_variety],
        :seed_brand => params[:seed_brand],
        :seed_quantity => params[:seed_quantity],
        :seed_notes => params[:seed_notes],
        :user_id => user.id)
      flash[:notice] = "Your seed entry has been updated!"
      redirect to "/seeds/#{@seed.id}"
    end
  end

  delete '/seeds/:id/delete' do
    if is_logged_in?
      @seed = Seed.find_by_id(params[:id])
      if @seed.user_id == session[:user_id]
        @seed.delete
        flash[:notice] = "The seed entry was deleted."
        redirect to '/seeds'
      end
    else
      flash[:notice] = "Looks like you weren't logged in yet. Please log in below."
      redirect to '/login'
    end
  end

end
