require 'spec_helper'

describe SendController do
  before :each do
    @user = mock()
    @userid = 5
    @fakerecent = mock()
    @user.stub(:id).and_return(@userid)
  end

  describe 'selection page' do
    it 'should render the selection page' do
      get :index
      response.should render_template 'index'
    end
  end
  
  describe 'sending a ecard' do
    describe 'the ecard form' do
      it 'should find recent ecards if logged in' do
        session[:userid] = @userid
        User.should_receive(:find_by_id).with(@userid).and_return(@user)
        @user.should_receive(:get_recent_ecards).with(SendController::RECENT_COUNT).and_return(@fakerecent)
        get :ecard_new
        assigns @recent => @fakerecent
      end
      
      it 'should render ecard form page' do
        session[:userid] = @userid
        User.stub(:find_by_id).with(@userid).and_return(nil)
        get :ecard_new
        response.should render_template 'ecard'
      end
    end
    describe 'creating a ecard' do
      before :each do
        @ecard = mock()
        @params = {}
        @fakeerror = mock()
        @fakeerror.stub(:full_messages).and_return ["invalid entry", "bad data"]
        Ecard.stub(:new).with(@params[:card]).and_return(@ecard)
        @mailer = mock()
        @mailer.stub :deliver
        @ec = mock()
        @ec.stub(:push)
      end
      it 'should set uesrs if logged in' do
        session[:userid] = @userid
        User.should_receive(:find_by_id).with(@userid).and_return(@user)
        @ecard.stub(:valid?).and_return(false)
        @ecard.stub(:errors).and_return(@fakeerror)
        post :ecard_create, @params
        assigns :user => @user
      end
      it 'should warn users if card is not valid' do
        @ecard.should_receive(:valid?).and_return(false)
        @ecard.stub(:errors).and_return(@fakeerror)
        post :ecard_create, @params
        flash[:error].length.should be > 0
      end
      it 'should redirect to send ecard page if card is not valid' do
        @ecard.stub(:valid?).and_return(false)
        @ecard.stub(:errors).and_return(@fakeerror)
        post :ecard_create, @params
        response.should redirect_to send_ecard_path
      end
      it 'should flash and save card if card is valid' do
        @ecard.stub(:valid?).and_return(true)
        EcardMailer.stub(:ecard_email).and_return(@mailer)
        post :ecard_create, @params
        flash[:notice].length.should be > 0
      end
      it 'should add card to ecards and save if card is valid and logged in' do
        User.stub(:find_by_id).and_return(@user)
        @ecard.stub(:valid?).and_return(true)
        @user.should_receive(:save)
        @user.should_receive(:ecards).and_return(@ec)
        @ec.should_receive(:push).with(@ecard)
        EcardMailer.stub(:ecard_email).and_return(@mailer)
        post :ecard_create, @params
        flash[:notice].length.should be > 0
      end
      it 'should actually send card if card is valid' do
        @ecard.stub(:valid?).and_return(true)
        EcardMailer.should_receive(:ecard_email).with(@ecard).and_return(@mailer)
        post :ecard_create, @params
        flash[:notice].length.should be > 0
      end
      it 'should redirect to send index if card is valid' do 
        @ecard.stub(:valid?).and_return(true)
        EcardMailer.stub(:ecard_email).and_return(@mailer)
        post :ecard_create, @params
        response.should redirect_to send_path
      end
    end
  end

    
  describe 'sending a postcard' do
    describe 'postcard form' do
      it 'should redirect users if not logged in' do
        session[:userid] = @userid
        User.should_receive(:find_by_id).with(@userid).and_return(nil)
        get :postcard_new
        flash[:error].length.should be > 0
        response.should redirect_to login_path
      end
      it 'should redirect users if exceed card sending limit for account' do
        User.stub(:find_by_id).and_return(@user)
        @user.should_receive(:can_send_postcard).and_return(false)
        get :postcard_new
        flash[:error].length.should be > 0
        response.should redirect_to send_path
      end
      it 'should find recent postcards if logged in' do
        session[:userid] = @userid
        User.should_receive(:find_by_id).with(@userid).and_return(@user)
        @user.stub(:can_send_postcard).and_return(true)
        @user.should_receive(:get_recent_postcards).with(SendController::RECENT_COUNT).and_return(@fakerecent)
        get :postcard_new
        assigns @recent => @fakerecent
      end
      it 'should render postcard form for valid users' do
        session[:userid] = @userid
        User.stub(:find_by_id).and_return(@user)
        @user.stub(:can_send_postcard).and_return(true)
        @user.stub(:get_recent_postcards).and_return(@fakerecent)
        get :postcard_new
        response.should render_template :postcard
      end
    end
    describe 'creating a postcard' do
      before :each do
        @postcard = mock()
        @params = {}
        @fakeerror = mock()
        @fakeerror.stub(:full_messages).and_return ["invalid entry", "bad data"]
        @pc = mock()
        @pc.stub(:push)
        Postcard.stub(:new).with(@params[:card]).and_return(@postcard)
      end
      it 'should redirect users if not logged in' do
        session[:userid] = @userid
        User.should_receive(:find_by_id).with(@userid).and_return(nil)
        post :postcard_create, @params
        flash[:error].length.should be > 0
        response.should redirect_to login_path
      end
      it 'should redirect users if exceed card sending limit for account' do
        session[:userid] = @userid
        User.stub(:find_by_id).and_return(@user)
        @user.should_receive(:can_send_postcard).and_return(false)
        post :postcard_create, @params
        flash[:error].length.should be > 0
        response.should redirect_to send_path
      end
      it 'should warn users if card is not valid' do
        User.stub(:find_by_id).and_return(@user)
        @user.stub(:can_send_postcard).and_return(true)
        @postcard.should_receive(:valid?).and_return(false)
        @postcard.stub(:errors).and_return(@fakeerror)
        post :postcard_create, @params
        flash[:error].length.should be > 0
      end
      it 'should redirect to send postcard page if card is not valid' do
        User.stub(:find_by_id).and_return(@user)
        @user.stub(:can_send_postcard).and_return(true)
        @postcard.stub(:valid?).and_return(false)
        @postcard.stub(:errors).and_return(@fakeerror)
        post :postcard_create, @params
        response.should redirect_to send_postcard_path
      end
      it 'should flash and save card if card is valid' do
        User.stub(:find_by_id).and_return(@user)
        @user.stub(:can_send_postcard).and_return(true)
        @postcard.should_receive(:valid?).and_return(true)
        @user.should_receive(:save)
        @user.stub(:postcards).and_return(@pc)
        post :postcard_create, @params
        flash[:notice].length.should be > 0
      end
      it 'should add to postcards if card is valid' do 
        User.stub(:find_by_id).and_return(@user)
        @user.stub(:can_send_postcard).and_return(true)
        @postcard.stub(:valid?).and_return(true)
        @user.stub(:save)
        @user.should_receive(:postcards).and_return(@pc)
        @pc.should_receive(:push).with(@postcard)
        post :postcard_create, @params
        response.should redirect_to send_path
      end
      it 'should redirect to send index if card is valid' do 
        User.stub(:find_by_id).and_return(@user)
        @user.stub(:can_send_postcard).and_return(true)
        @postcard.stub(:valid?).and_return(true)
        @user.stub(:save)
        @user.stub(:postcards).and_return(@pc)
        post :postcard_create, @params
        response.should redirect_to send_path
      end
    end
   
  end
  
    
    
    
end  

      
    
