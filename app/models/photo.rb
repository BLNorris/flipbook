class Photo < ActiveRecord::Base
  attr_accessible :description, :flipbook_id, :url
  
  belongs_to :flipbk
end
