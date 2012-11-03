require 'spec_helper'

describe RegisterController do

  describe 'registration page' do
    it 'should render the registration page' do
      get :new
      response.should render_template 'index'
    end
  end
  
  describe 'registering a user' do
    before :each do
      @user = mock()
      @userid = 5
      @username = 'michelle'
      @user.stub(:id).and_return(@userid)
			@user.stub(:name).and_return @username
      @good_params = {:user => {:password => 'good', :email => 'eric@test.com', :subscribed => "1", :name => 'eric'}, :confirm => 'good'}
      @bad_params = {:user => {}, :confirm => 'bad'}
      @fakeerror = mock()
      @fakeerror.stub(:full_messages).and_return ["invalid entry", "bad data"]
      @mailer = mock()
      @mailer.stub :deliver
    end
    
    it 'should check if the form is complete' do
      User.should_receive(:new).and_return @user
      @user.should_receive(:valid?).and_return false
      @user.stub(:errors).and_return(@fakeerror)
      post :create, @bad_params
    end
    
    
    it 'should check if password and confirm password match' do
      User.stub(:new).and_return @user
      @user.stub(:valid?).and_return false
      @user.stub(:errors).and_return(@fakeerror)
      post :create, @bad_params
      assigns :valid => false
      flash[:error].should include 'Passwords do not match'
    end
  

    describe 'after incomplete form' do
      it 'should redirect user back to registration page' do
        User.stub(:new).and_return @user
        @user.stub(:valid?).and_return false
        @user.stub(:errors).and_return(@fakeerror)
        post :create, @bad_params
        response.should redirect_to register_path
      end
      it 'should say \'give reasons for incomplete form\'' do
        User.stub(:new).and_return @user
        @user.stub(:valid?).and_return false
        @user.should_receive(:errors).and_return(@fakeerror)
        post :create, @bad_params
        flash[:error].length.should be > 0
      end
    end
    describe 'after successful form' do
      it 'should set session with users id' do
        User.stub(:new).and_return @user
        @user.stub(:valid?).and_return true
        @user.stub :save
        UserMailer.stub(:register_email).and_return(@mailer)
        post :create, @good_params
        session[:userid].should eq @userid
      end
      it 'should flash a thanks message' do
        User.stub(:new).and_return @user
        @user.stub(:valid?).and_return true
        @user.should_receive :save
        UserMailer.stub(:register_email).and_return(@mailer)
        post :create, @good_params
      end
      it 'should send user an email' do
        User.stub(:new).and_return @user
        @user.stub(:valid?).and_return true
        @user.stub :save
        UserMailer.should_receive(:register_email).with(@user).and_return(@mailer)
        post :create, @good_params
      end
      it 'should redirect user to registration acknowledgement page' do
        User.stub(:new).and_return @user
        @user.stub(:valid?).and_return true
        @user.stub :save
        UserMailer.stub(:register_email).and_return(@mailer)
        post :create, @good_params
        response.should redirect_to send_path 
      end 
    end
  end
end  

      
    
