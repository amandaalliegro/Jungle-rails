class User < ActiveRecord::Base
  has_secure_password
  validates :password, presence: true, length: { minimum: 7 }
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.authenticate_with_credentials(email, password)
    email.strip!
    user = User.where('lower(email) = ?', email.downcase).first 
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
  
end