class LoginController < ApplicationController

  def index
    render "index"
  end
  
  def login
    @user = User.valid_user params[:user][:email], params[:user][:password]
    if @user.nil? 
      flash[:error] = "Email and password combination do not match, try again!"
      render "index"
    else
    	flash[:notice] = "Welcome, <strong>" + @user.name + "</strong>!"
      session[:userid] = @user.id
      redirect_to welcome_path
    end
  end
  
  def logout
    session.delete :userid
    flash[:notice] = 'Logged out successfully'
    redirect_to welcome_path
  end


end
