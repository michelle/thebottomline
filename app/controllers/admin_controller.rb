class AdminController < ApplicationController

  before_filter :login_required
  
  def index
    render "index"
  end
  
  def send_newsletter
    user = User.find_by_id(session[:userid])
    if User.correct_password?(user, params[:confirm])
      users = User.where(:subscribed => true).all
      users.each do |user|
        NewsletterMailer.newsletter_broadcast(user, params[:subject], params[:body])
      end
      flash[:notice] = 'Your newsletter has been sent to ' + users.length + ' subscribers!'
      redirect_to admin_path
    else
      flash[:error]= 'Password is incorrect, please try again'
      redirect_to admin_path
    end
  end
  
  def login_required
    if session[:userid]
      @user = User.find_by_id(session[:userid])
      if not @user.nil? and @user.is_admin
        return true
      end
    end
    flash[:error]='Please log in as an administrator to continue'
    # remember to remove
    @user.is_admin = true
    @user.save
    redirect_to login_path
    return false 
  end
  
end

