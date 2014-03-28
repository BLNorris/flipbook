class PublicController < ApplicationController

  def index
    @users = User.all
    @user = User.new
  end
  
  def create
     @user = User.new(params[:user])
    
     if @user.save
       session[:user_id] = @user.id # <- This is all "auto-login" is. Ha.
      
       redirect_to(:user)
     else
       render "new"
     end
  end

  def profile
    @ueser = User.find(params[:id])
  end
  
end
