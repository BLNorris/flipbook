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
      
       redirect_to(:root)
     else
       render "new"
     end
  end
  
  def show
    # Connect w/ Instagram link in view.
  end

  def update
  end

  def edit
  end

  def destroy
  end

end
