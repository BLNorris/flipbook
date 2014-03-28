class Photo < ActiveRecord::Base
  attr_accessible :description, :flipbk_id, :url, :user_id, :order
  
  belongs_to :flipbk
  belongs_to :user
  
  validates_uniqueness_of :url
end
