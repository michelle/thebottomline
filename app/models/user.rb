require 'bcrypt'

class User < ActiveRecord::Base
  
  validates :name, :presence => true
  validates :email, :uniqueness => true, :presence => true
  validates :password, :length => {:minimum => 4}, :presence => true
  
  before_create :encrypt_password
  
  def encrypt_password
    self.password = BCrypt::Password.create(self.password)
  end
  
  #def login
  #  @user = User.find_by_email(self.email)
  #  if @user.password == 
  #end
  
end
