require 'spec_helper'

describe AdminController do


  it 'should flash and redirect if user is not logged in' do
    get :index
    flash[:error].length.should be > 0
    response.should redirect_to login_path 
  end
   
  it 'should flash and redirect if user is not admin' do
    userid = 'id'
    session[:userid] = userid
    @user = mock()
    @user.should_receive(:is_admin).and_return(false)
    User.should_receive(:find_by_id).with(userid).and_return(@user)
    get :index
    flash[:error].length.should be > 0
    response.should redirect_to login_path 
  end

  describe 'logged in admin user' do
    before :each do
      userid = 'id'
      session[:userid] = userid
      @user = mock()
      @user.stub(:is_admin).and_return(true)
      User.stub(:find_by_id).and_return(@user)
      get :index
    end
  
    it 'should render index' do
      get :index
      response.should render_template 'index'
    end
    
    describe 'sending newsletters' do
      before :each do
        @wrongpass = 'x'
        @rightpass = 'y'
        @data = {:body => 'val', :subject => 'val2', :confirm => @wrongpass}
      end
      
      it 'should flash error and values and redirect if password not confirmed' do
        User.should_receive(:correct_password?).with(@user, @wrongpass).and_return(false)
        post :send_newsletter, @data
        flash[:error].length.should be > 0
        flash[:subject].should eq @data[:subject]
        flash[:body].should eq @data[:body]
        response.should redirect_to admin_path 
      end
      
      describe 'sending correct password' do
        before :each do
          @data[:confirm] = @rightpass
          @user1 = mock()
          @user2 = mock()
          @users = [@user1, @user2]
          User.stub(:correct_password?).and_return(true)
          @query = mock()
          User.stub(:where).and_return(@query)
          @query.stub(:all).and_return(@users)
        end
        it 'should query for all subscribed users' do
          query = mock()
          User.should_receive(:where).with(:subscribed => true).and_return(query)
          query.should_receive(:all).and_return([])
          post :send_newsletter, @data
        end
        it 'should loop through subscribed users' do
          @users.should_receive(:each)
          post :send_newsletter
        end
        it 'should call newsletter broadcast on subscribed users' do
        	mailer = mock()
        	mailer.stub(:deliver)
          NewsletterMailer.should_receive(:newsletter_email).twice.and_return mailer
          post :send_newsletter
        end
        
      end
      
      
    end
  end
    
end  

      
    
