class Flipbk < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :speed, :public, :url, :display, :order
                 
  
  belongs_to :user
  has_many :photos
end
