require 'spec_helper'
require 'bcrypt'

describe User do
  user = FactoryGirl.create(:user,
                            :name=>"President Skroob",
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
    it 'should get the most recently created AMOUNT ecards' do
      user.get_recent_ecards(1).count.should == 0
      user.ecards.create(:recipient => "grandma", :address => "koolgrandma103@gmail.com", :sender => "grandson")
      ecards = user.get_recent_ecards(1)
      ecards.count.should == 1
      ecards[0].recipient.should == "grandma"
      user.ecards.create(:recipient => "grandpa", :address => "koolgrandpa103@gmail.com", :sender => "grandson")
      ecards = user.get_recent_ecards(1)
      ecards.count.should == 1
      ecards[0].recipient.should == "grandpa"
    end
  end
  describe 'Get recent postcards' do
    it 'should get the most recently created AMOUNT postcards' do
      user.get_recent_postcards(1).count.should == 0
      user.postcards.create(:recipient => "grandma", :address => "2316 Haste St, Berkeley, CA 94704", :sender => "grandson")
      postcards = user.get_recent_postcards(1)
      postcards.count.should == 1
      postcards[0].recipient.should == "grandma"
      user.postcards.create(:recipient => "grandpa", :address => "2316 Haste St, Berkeley, CA 94704", :sender => "grandson")
      postcards = user.get_recent_postcards(1)
      postcards.count.should == 1
      postcards[0].recipient.should == "grandpa"
    end
  end
  describe 'Check if user can send more postcards' do
    it 'should return true if user has less than 2 postcards, false o/w' do
      user.can_send_postcard?.should be true
      user.postcards.create(:recipient => "grandma", :address => "2316 Haste St, Berkeley, CA 94704", :sender => "grandson")
      user.can_send_postcard?.should be true
      user.postcards.create(:recipient => "grandpa", :address => "2316 Haste St, Berkeley, CA 94704", :sender => "grandson")
      user.can_send_postcard?.should be false
    end
  end
end
