require 'spec_helper'

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
        valid_user = User.valid_user("skroobydoo@spaceballs.com", "1234")
        valid_user.should == nil
      end
    end
    describe 'Correct password' do
      it 'should return the user' do
        valid_user = User.valid_user("skroobydoo@spaceballs.com", "12345")
        valid_user.should == user
      end
    end
  end
end
