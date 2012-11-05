class SettingsController < ApplicationController 
  def index
    @user = User.find_by_id session[:userid]
    if (not @user.nil?)
			@subscribed = @user.subscribed?
			render "index"
    else
			redirect_to login_path
    end
  end 

  def update
  	@current_user = User.find_by_id session[:userid]
  	@user = User.valid_user @current_user.email, params[:password]
  	if @user.nil?
  		flash[:error] = "Please enter your old password to change your details."
  		redirect_to settings_path
  		return
		end
    @user.name = params[:user][:name]
		@user.password = params[:user][:password] == '' ? params[:password] : params[:user][:password]
		@user.subscribed = params[:user][:subscribed]
    @valid = @user.valid?
    errors = []
    if !params[:user][:password].nil? and params[:confirm] != params[:user][:password]
      flash[:error] = errors << "Passwords do not match"
      @valid = false
    end
    if not @valid
      flash[:error] = @user.errors.full_messages.concat(errors).join "<br>"
      redirect_to settings_path
    else
    	@user.save
    	session[:name] = @user.name
      flash[:notice] = "User settings updated."
      redirect_to settings_path
    end     
  end
end
