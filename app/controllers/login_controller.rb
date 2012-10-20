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

	def forgot_password
		render "lostpassword"
	end

  def send_password
  	success = User.forgot_password(params[:email])
  	if success
  		flash[:notice] = 'Password successfully sent'
			redirect_to welcome_path
		else
			flash[:error] = 'Email not found. <a href="/register">Register?</a>'
  		render 'lostpassword'
		end
	end

end
