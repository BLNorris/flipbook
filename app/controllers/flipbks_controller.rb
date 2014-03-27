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
    @book = Flipbk.find(params[:id])
    @book.update_attributes(params[:flipbk])
    @book.user_id = session[:user_id]
    
    if @book.save
      Photo.all.each do |p|
        if p.flipbk_id == @book.id
          p.flipbk_id = nil
          p.save
        end
      end
      if params[:photos]      
        params[:photos].each do |p|
          photo = Photo.find(p)
          photo.flipbk_id = @book.id
          photo.save
        end
      end
      redirect_to(flipbk_path(@book.id))
    else
      render "edit"
    end
  end

  def edit
    @book = Flipbk.find(params[:id])
  end

  def destroy
    book = Flipbk.find(params[:id])
    book.photos.each do |p|
      p.flipbk_id = nil
    end
    book.delete
    redirect_to(:users)
  end

  def index
    @user = User.find(session[:user_id])

  end

  def show
    
    
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
    @book = Flipbk.find(params[:id])
    
    if @book.public?
      puts "ITS PUBLIC YO"
    
    else
      if current_user &&@book.user.id == current_user.id
      else
      redirect_to(:root)
      end
    end
    
  end
  

  
end
