class UsersController < ApplicationController
  
  Instagram.configure do |config|
    config.client_id = ENV["INSTAGRAM_CLIENT_ID"]
    config.client_secret = ENV["INSTAGRAM_CLIENT_SECRET"]
  end
  
  def connect
    redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
  end
  
  def callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
    session[:access_token] = response.access_token
    redirect :user
  end
  
  def index
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
       render "show"
     end
  end
  
  def show
    @client = Instagram.client(:access_token => session[:access_token])
    @user = @client.user
    redirect :photos
  end

  def update
  end

  def edit
  end

  def destroy
  end

end
