class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation
  validates :email, :uniqueness => true
  validates :password, length: { minimum: 6 }
end
