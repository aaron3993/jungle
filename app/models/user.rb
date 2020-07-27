class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true
  # validates :password_confirmation: { case_sensitive: true }
  # validates :password, password_confirmation: { case_sensitive: true }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      return user
    end
  end

  has_secure_password
  
end
