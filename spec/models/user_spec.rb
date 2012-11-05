require 'spec_helper'
require 'bcrypt'

describe User do
  before(:each) do
    @user = FactoryGirl.create(:user,
                              :name=>"President Skroob",
                              :email=>"skroobydoo@spaceballs.com",
                              :password=>"12345")
    @user2 = FactoryGirl.create(:user,
                                :name=>"granny deffo",
                                :email=>"coolgranny@gmail.com",
                                :password=>"12345")
  end
  describe 'adding a user' do
    it 'should encrypt the given password in the database' do
      user_in_database = User.find(@user.id)
      user_in_database.password.should_not == "12345"
    end
    it 'should capitalize the user\'s name' do
      user2_in_database = User.find(@user2.id)
      user2_in_database.name.should == "Granny Deffo"
    end
  end
  describe 'validating a password' do
    describe 'Incorrect password' do
      it 'should return nil' do
        User.stub(:find_by_email).and_return(@user)
        valid_user = User.valid_user("skroobydoo@spaceballs.com", "1234")
        valid_user.should == nil
      end
    end
    describe 'correct password' do
      it 'should return the user' do
        User.stub(:find_by_email).and_return(@user)
        valid_user = User.valid_user("skroobydoo@spaceballs.com", "12345")
        valid_user.should == @user
      end
    end
  end
  describe 'forgot email' do
    it 'should not have old password as the new password' do
      User.stub(:find_by_email).and_return(@user)
      old_user_password = @user.password
      User.forgot_password(@user.email)
      user_in_database = User.find(@user.id)
      user_in_database.password.should_not be old_user_password
    end
  end
  describe 'get subscription flag' do
    it 'should let caller know if user is subscribed' do
      User.stub(:find_by_email).and_return(@user2)
      user_in_database = User.find(@user2.id)
      User.subscribed?(user_in_database).should == true
    end
  end
  describe 'get recent ecards' do
    it 'should get the most recently created AMOUNT ecards' do
      @user.get_recent_ecards(1).count.should == 0
      @user.ecards.create(:recipient => "grandma", :address => "koolgrandma103@gmail.com", :sender => "grandson")
      ecards = @user.get_recent_ecards(1)
      ecards.count.should == 1
      ecards[0].recipient.should == "grandma"
      @user.ecards.create(:recipient => "grandpa", :address => "koolgrandpa103@gmail.com", :sender => "grandson")
      ecards = @user.get_recent_ecards(1)
      ecards.count.should == 1
      ecards[0].recipient.should == "grandpa"
    end
  end
  describe 'get recent postcards' do
    it 'should get the most recently created AMOUNT postcards' do
      @user.get_recent_postcards(1).count.should == 0
      @user.postcards.create(:recipient => "grandma", :address => "2316 Haste St, Berkeley, CA 94704", :sender => "grandson")
      postcards = @user.get_recent_postcards(1)
      postcards.count.should == 1
      postcards[0].recipient.should == "grandma"
      @user.postcards.create(:recipient => "grandpa", :address => "2316 Haste St, Berkeley, CA 94704", :sender => "grandson")
      postcards = @user.get_recent_postcards(1)
      postcards.count.should == 1
      postcards[0].recipient.should == "grandpa"
    end
  end
  describe 'check if user can send more postcards' do
    it 'should return true if user has less than 2 postcards, false o/w' do
      @user.can_send_postcard?.should be true
      @user.postcards.create(:recipient => "grandma", :address => "2316 Haste St, Berkeley, CA 94704", :sender => "grandson")
      @user.can_send_postcard?.should be true
      @user.postcards.create(:recipient => "grandpa", :address => "2316 Haste St, Berkeley, CA 94704", :sender => "grandson")
      @user.can_send_postcard?.should be false
    end
  end
end
