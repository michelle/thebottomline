require 'spec_helper'

describe LoginController do

  describe 'login page' do
    it 'should render the login page' do
      get :index
      response.should render_template 'index'
    end
  end
  
  describe 'logout page' do
    it 'should log user out and flash' do
      get :logout
      flash[:notice].should include 'Logged out successfully'
      response.should redirect_to welcome_path
    end
    it 'should log user out and redirect' do
      get :logout
      response.should redirect_to welcome_path
    end
    it 'should log user out and destroy session' do
      get :logout
      session[:userid].should be_nil
    end
  end
  
  describe 'log in a user' do
    before :each do
      @user = mock()
      @userid = 5
      @username = 'testuser'
      @user.stub(:name).and_return @username
      @user.stub(:id).and_return @userid
      @params = {:user => {:name => 'testuser', :email => 'asdf@asdf.com', :password => 'abc'}}
    end
    
    it 'should call valid_user' do
      User.should_receive(:valid_user)
      post :login, @params
    end
    
    it 'should flash error if invalid credentials' do
      User.stub(:valid_user)
      post :login, @params
      flash[:error].should include 'Email and password combination do not match, try again!'
    end
    
    it 'should render login page again if invalid credentials' do
      User.stub(:valid_user)
      post :login, @params
      response.should render_template 'index'
    end
    
        
    it 'should set session error if valid credentials' do
      User.stub(:valid_user).and_return @user
      post :login, @params
      session[:userid].should eq @userid
    end
    
    it 'should redirect if valid credentials' do
      User.should_receive(:valid_user).and_return @user
      post :login, @params
      response.should redirect_to welcome_path
      flash[:notice].should eq 'Welcome, <strong>' + @user.name + '</strong>!'
    end
  end
end  

      
    
