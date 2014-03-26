class FlipbksController < ApplicationController
  def new
        @book = Flipbk.new
  end

  def create
    @book = Flipbk.new(params[:flipbk])
    @book.user_id = session[:user_id]
    
    if @book.save
      if params[:photos]      
        params[:photos].each do |p|
          photo = Photo.find(p)
          photo.flipbk_id = @book.id
          photo.save
        end
      end
      redirect_to(flipbk_path(@book.id))
    else
      render "new"
    end
  end

  def update
  end

  def edit
  end

  def destroy
    book = Flipbk.find(params[:id])
    book.photos.each do |p|
      p.flipbk_id = nil
    end
    book.delete
    redirect_to(:flipbks)
  end

  def index
    @user = User.find(session[:user_id])
  end

  def show
    @user = User.find(session[:user_id])
    @book = Flipbk.find(params[:id])
  end
  

  
end
