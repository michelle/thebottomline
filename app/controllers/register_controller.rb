class RegisterController < ApplicationController

  def new
    render index
  end
  
  def create
    @user = Users.new params[:user]
    if @user.valid?
      @user.save
      session[:userid] = @user.id
      redirect_to dashboard_path
    else
      flash[:error] = @user.errors.full_messages.join "<br>"
      render index
    end
  end
  
  def destroy
    session.delete :userid
    flash[:notice] = 'Logged out successfully'
  end

end
