class Photo < ActiveRecord::Base
  attr_accessible :description, :flipbook_id, :url
end
