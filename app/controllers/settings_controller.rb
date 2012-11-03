class SettingsController < ActionController::Base

  def index
    if(session[:userid] != nil)
       render "index"
    else
       redirect_to welcome_path
    end
  end 

  def update
    @subscribed = User.find(session[:userid]).subscribed?
    @valid = @user.valid?
    errors = []
    if params[:confirm] != params[:user][:password]
      flash[:error] = errors << "Passwords do not match"
      @valid = false
    end
    if not @valid
      flash[:error] = @user.errors.full_messages.concat(errors).join "<br>"
      redirect_to settings_path
    else
      flash[:notice] = "You Successfully Updated Your User Settings!"
      @user.update(:name => params[:user], :password => params[:confirm], :subscribed => params[:subscribed])
      session[:userid] = @user.id
      redirect_to welcome_path
    end     
  end

end
