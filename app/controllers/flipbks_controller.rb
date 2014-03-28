class FlipbksController < ApplicationController
  def new
        @book = Flipbk.new
  end

  def create

 
    @book = Flipbk.new(params[:flipbk])
    @book.user_id = session[:user_id]
    
    if @book.save
      dir = "#{RAILS_ROOT}/tmp/#{@book.id}/"
      name = "#{@book.user_id}-#{@book.id}-#{@book.name.gsub(/\s+/, "")}"
      
      orders = []
      if params[:order]
        params[:order].each do |o|
          p = o.split("-")
          orders << p
        end
      end

      
      if params[:photos]      
        params[:photos].each do |p|
          photo = Photo.find(p)
          
          orders.each do |o|
            photo.order = o[1] if photo.id == o[0]
          end
          
          
          photo.flipbk_id = @book.id
          photo.save
        end
      end
      

      
      sorted = @book.photos.sort_by &:order
      sorted.each_with_index do |photo, index| 
        Dir.mkdir(dir) unless File.exists?(dir)
        open("#{dir}image#{photo.order}#{photo.id}.png", 'wb') do |file|
        file << open(photo.url).read
        end
      end
      
      save_to_s3(@book, dir, name)
      

      #FileUtils.remove_dir(dir,true)

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
      dir = "#{RAILS_ROOT}/tmp/#{@book.id}/"
      name = "#{@book.user_id}-#{@book.id}-#{@book.name.gsub(/\s+/, "")}"
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
          Dir.mkdir(dir) unless File.exists?(dir)
          open("#{dir}image#{photo.id}.png", 'wb') do |file|
            file << open(photo.url).read
          end
        end
      end
      
      save_to_s3(@book, dir, name)
      

      FileUtils.remove_dir(dir,true)
      
      
      redirect_to(flipbk_path(@book.id))
    else
      render "edit"
    end
  end

  def edit
    @book = Flipbk.find(params[:id])
  end

  def destroy
    
    puts "ITS TOTALLY HITTINF DESTROY"
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

    
    else
      if current_user &&@book.user.id == current_user.id
      else
      redirect_to(:root)
      end
    end
    
  end
  
  private
  
  def save_to_s3(book, dir, name)
    service = S3::Service.new(
      :access_key_id     => "AKIAJM6AC663FA3WLTSQ", 
      :secret_access_key => "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"
    )
    
    speed = @book.speed / 10
    system("convert -delay #{speed} #{dir}*.png #{dir}#{name}.gif")
    
    
    #sedt dir/flipbook.gif to amazon s3 and then save public url to flipbk
    
    bucket = service.buckets.find("flipbook-ocs")

    new_object = bucket.objects.build("#{name}.gif")

    new_object.content = open("#{dir}#{name}.gif")

    new_object.save
    
    object = bucket.objects.find("#{name}.gif")
    @book.url = object.url

    @book.save
    
  end

  
end
