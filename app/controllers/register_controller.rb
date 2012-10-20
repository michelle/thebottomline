class RegisterController < ApplicationController

  def new
    render "index"
  end
  
  def create
    @user = Users.new params[:user]
    valid = @user.valid?
    if params[:confirm]
      flash[:error] = @user.errors.full_messages << "Passwords do not match"
      valid = false
    end
    if not valid
      flash[:error] = @user.errors.full_messages.join "<br>"
      render "index"
    else
      @user.save
      session[:userid] = @user.id
      redirect_to dashboard_path
    end
  end
  
  def destroy
    session.delete :userid
    flash[:notice] = 'Logged out successfully'
  end

end
