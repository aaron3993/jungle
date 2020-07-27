class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password, confirmation: { case_sensitive: true }
  validates_presence_of :password_confirmation, :if => :password_changed?
  
  has_secure_password
  
end
