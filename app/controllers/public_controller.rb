class PublicController < ApplicationController

  def index
    @users = User.all
    @user = User.new
    @public_flipbks =  []
    Flipbk.all.each do |f|
      if f.public
        @public_flipbks << f
        puts "FOUND PUBLIC ONE WOOOO"
      end
      puts "LOOPING THRU BOOKS"
    end
    puts "WTF YO!!!!"
    
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
    @user = User.find(params[:id])
  end
  
end
