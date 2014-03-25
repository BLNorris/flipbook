class PhotosController < ApplicationController
  
  def feed
    @client = Instagram.client(:access_token => session[:access_token])
    @user = @client.user
    
    for media_item in @client.user_recent_media
      photo_url = media_item.images.standard_resolution.url
      photo = Photo.create(:url => photo_url) 
    end
  end
  
end
