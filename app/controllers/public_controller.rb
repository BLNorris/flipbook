class PublicController < ApplicationController


  def index
  end


  def profile
    @user = User.new
  end
  
end
