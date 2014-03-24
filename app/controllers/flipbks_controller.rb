class FlipbksController < ApplicationController
  def new
  end

  def create
    @book = Flipbk.new(params[:flipbk])
    @book.user_id = session[:user_id]
    
    if @book.save
     
      redirect_to(flipbk_path(session[:user_id]))
    else
      render "newtest"
    end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def show
    @user = User.find(session[:user_id])
  end
  
  def newtest
    @book = Flipbk.new
    
  end
  
end
