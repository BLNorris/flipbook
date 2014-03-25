class Photo < ActiveRecord::Base
  attr_accessible :description, :flipbk_id, :url
  
  belongs_to :flipbk
end
