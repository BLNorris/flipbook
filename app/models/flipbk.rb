class Flipbk < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :speed, :public, :url, :display
  
  has_attached_file :display, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :display, :content_type => /\Aimage\/.*\Z/
                     
  
  belongs_to :user
  has_many :photos
end
