class Photo < ActiveRecord::Base
  attr_accessible :description, :flipbk_id, :url, :user_id
  
  belongs_to :flipbk
  belongs_to :user
end
