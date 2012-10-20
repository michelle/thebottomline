class RegisterController < ApplicationController

  def new
    render "index"
  end
  
  def create
    @user = User.new params[:user]
    valid = @user.valid?
    errors = []
    if params[:confirm] != params[:user][:password]
      flash[:error] = errors << "Passwords do not match"
      valid = false
    end
    if not valid
      flash[:error] = @user.errors.full_messages.concat(errors).join "<br>"
      render "index"
    else
      @user.save
      session[:userid] = @user.id
      redirect_to dashboard_path
    end
  end
  
end
