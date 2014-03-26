class PublicController < ApplicationController


  def index
    @users = User.all
  end


  def profile
    @user = User.find(params[:id])
  end
  
end
