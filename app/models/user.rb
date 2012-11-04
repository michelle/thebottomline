require 'bcrypt'

class User < ActiveRecord::Base

  validates :name, :presence => true
  validates :email, :uniqueness => true, :presence => true
  validates :password, :length => {:minimum => 4}, :presence => true

  has_many :cards

  before_save :encrypt_password

  def encrypt_password
    self.password = BCrypt::Password.create(self.password)
  end

  def self.valid_user(email, password)
    user = User.find_by_email(email)
    if !user.nil? and self.correct_password?(user, password)
      return user
    else
      return nil
    end
  end

  def self.correct_password?(user, password)
    my_password = BCrypt::Password.new(user.password)
    return my_password == password
  end

  def self.forgot_password(email)
    user = User.find_by_email(email)
    if user.nil? then return false end
    random_password = Array.new(10).map { (65 + rand(58)).chr }.join
    user.password = random_password
    user.save!
    UserMailer.password_change(user,random_password).deliver
    return true
  end

  def self.subscribed?(userId)
    return User.find(userId).subscribed
  end

  def get_recent_ecards(amount)
    #returns Array of last amount ecards
  end

  def get_recent_postcards(amount)
    #returns Array of last amount postcards
  end

  def can_send_postcard?
    #return boolean: true if sent less than 2 postcards
  end

end
