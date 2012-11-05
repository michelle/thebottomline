require 'spec_helper'

describe SettingsController do
  before :each do 
    @user = mock()
    @userid = 'test'
  end
  describe 'rendering login page' do
    it 'checks if user is logged in' do
      session[:userid] = @userid
      User.should_receive(:find_by_id).with(@userid).and_return(nil)
      get :index
    end
    it 'sets subscribed if user is logged in' do
      session[:userid] = @userid
      User.stub(:find_by_id).and_return(@user)
      @user.should_receive(:subscribed?).and_return true
      get :index
      assigns @subscribed => true
    end
    it 'renders settings page if user is logged in' do
      session[:userid] = @userid
      User.stub(:find_by_id).and_return(@user)
      @user.stub(:subscribed?)
      get :index
      response.should render_template 'index'
    end
    it 'should redirect to login if user is not logged in' do
      session[:userid] = @userid
      User.stub(:find_by_id).and_return(nil)
      get :index
      response.should redirect_to login_path
    end
  end
  
  describe 'updating settings' do
    before :each do
      session[:userid] = @userid
      @email = 'testemail'
      @password = 'oldpass'
      @name = 'testname'
      @user.stub(:name).and_return(@name)
      @user.stub(:name=)
      @user.stub(:email).and_return(@email)
      @user.stub(:email=)
      @user.stub(:password).and_return(@password)
      @user.stub(:password=)
      @user.stub(:subscribed).and_return(@subscribed)
      @user.stub(:subscribed=)
      User.stub(:find_by_id).and_return(@user)
      User.stub(:valid_user).and_return(@user)
      @user.stub(:valid?)
      @fakeerror = mock()
      @fakeerror.stub(:full_messages).and_return ["invalid entry", "bad data"]
      @user.stub(:errors).and_return(@fakeerror)
      @user.stub(:save)
      @params = {
        :password => 'test',
        :user => {}
      }
    end
    
    it 'finds the logged in user' do
      User.should_receive(:find_by_id).with(@userid).and_return(@user)
      post :update, @params 
    end
    
    it 'should validate the current user' do
      User.should_receive(:valid_user).with(@user.email, @params[:password]).and_return(@user)
      post :update, @params
    end
    
    it 'should flash and redirect if password is not valid' do
      User.should_receive(:valid_user).with(@user.email, @params[:password]).and_return(nil)
      post :update, @params
      flash[:error].should include 'Please enter your old password to change your details.'
      response.should redirect_to settings_path
    end
    
    it 'should set the name to the new name' do
      newname = 'hello'
      @params[:user][:name] = newname
      @user.should_receive(:name=).with(newname)
      post :update, @params
    end
    
    it 'should set the password to the old password if new password is empty' do
      @params[:user][:password] = ''
      @user.should_receive(:password=).with(@params[:password])
      post :update, @params
    end
    
    it 'should set the password to the new password' do
      newpass = 'hello'
      @params[:user][:password] = newpass
      @user.should_receive(:password=).with(newpass)
      post :update, @params
    end
    
    it 'should set subscribed to the new subscribed' do
      newsubscribed = true
      @params[:user][:subscribed] = newsubscribed
      @user.should_receive(:subscribed=).with(newsubscribed)
      post :update, @params
    end
    
    it 'should check if user is valid' do
      @user.should_receive(:valid?)
      post :update, @params
    end
    
    it 'should check if password and confirm password match' do
      @user.stub(:valid?).and_return(true)
      @params[:user][:password] = 'newpass'
      @params[:confirm] = 'asdf'
      post :update, @params
      assigns :valid => false
      flash[:error].should include 'Passwords do not match'
    end
    
    it 'should flash errors and redirect to settings page if not valid' do
      @user.stub(:valid?).and_return(false)
      post :update, @params
      flash[:error].length.should be > 0
      response.should redirect_to settings_path
    end
    
    it 'should save if valid' do
      @user.stub(:valid?).and_return(true)
      @user.should_receive(:save)
      post :update, @params
    end
 
    it 'should save name in the session if valid' do
      @user.stub(:valid?).and_return(true)
      post :update, @params
      session[:name].should eq @user.name
    end
    
    it 'should should redirect and flash if valid' do
      @user.stub(:valid?).and_return(true)
      post :update, @params
      flash[:notice].length.should be > 0
      response.should redirect_to settings_path
    end
    
  end
    
    
end  

      
    
