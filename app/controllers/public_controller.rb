class PublicController < ApplicationController


  def index
  end


  def profile
    @client = Tumblr::Client.new
    
  end
  
end
