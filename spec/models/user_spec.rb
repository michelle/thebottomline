require 'spec_helper'
require 'bcrypt'

describe User do
  user = User.create!(:name=>"President Skroob",
                      :email=>"skroobydoo@spaceballs.com",
                      :password=>"12345")
  describe 'Adding a user' do
    it 'should encrypt the given password in the database' do
      user_in_database = User.find(user.id)
      user_in_database.password.should_not == "12345"
    end
  end
  describe 'Validating a password' do
    describe 'Incorrect password' do
      it 'should return nil' do
        User.stub(:find_by_email).and_return(user)
        valid_user = User.valid_user("skroobydoo@spaceballs.com", "1234")
        valid_user.should == nil
      end
    end
    describe 'Correct password' do
      it 'should return the user' do
        User.stub(:find_by_email).and_return(user)
        valid_user = User.valid_user("skroobydoo@spaceballs.com", "12345")
        valid_user.should == user
      end
    end
  end
  describe 'User forgot email' do
    it 'should' do
      User.stub(:find_by_email).and_return(user)
      UserMailer.stub(:create_and_deliver_password_change)
      old_user_password = user.password
      User.forgot_password(user.email)
      user_in_database = User.find(user.id)
      user_in_database.password.should_not == old_user_password
    end
  end
  describe 'Get recent ecards' do
  end
  describe 'Get recent postcards' do
  end
  describe 'Check if user can send more postcards' do
  end
end
