class UsersController < ApplicationController
  
  
  Instagram.configure do |config|
    config.client_id = ENV["INSTAGRAM_CLIENT_ID"]
    config.client_secret = ENV["INSTAGRAM_CLIENT_SECRET"]
  end
  

  def connect
    redirect_to(Instagram.authorize_url(:redirect_uri => ENV["INSTAGRAM_CALLBACK_URL"]))
  end
  
  def callback

    response = Instagram.get_access_token(params[:code], :redirect_uri => ENV["INSTAGRAM_CALLBACK_URL"])
    session[:access_token] = response.access_token

    redirect_to(:feed)
  end

  
  def index
    if current_user
      redirect_to(:flipbks)
    end
  end
  
  def new
     @user = User.new
  end

  def create
     @user = User.new(params[:user])
    
     if @user.save
       session[:user_id] = @user.id # <- This is all "auto-login" is. Ha.
      
<<<<<<< HEAD
       redirect_to user_url(@user.id)
=======
       redirect_to(:root)
>>>>>>> a01ae725209d4e794a2562f90a43f2b679554a55
     else
       render "new"
     end
  end
  
  def show
    if params[:id].to_s == session[:user_id].to_s
      # Connect w/ Instagram link in view. <SHOULD HAPPEN
    else
      redirect_to profile_url params[:id].to_i
    end
    
    
  end

  def update
  end

  def edit
  end

  def destroy
  end

end
