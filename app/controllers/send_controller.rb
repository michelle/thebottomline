class SendController < ApplicationController

  RECENT_COUNT = 5

  def index
    render "index"
  end
  
  def ecard_new
    @user = User.find_by_id(session[:userid])
    if not @user.nil?
      @recent = @user.get_recent_ecards(SendController::RECENT_COUNT);
    end
    render "ecard"
  end
  
  def ecard_create
    @ecard = Ecard.new params[:card]
    @valid = @ecard.valid?
    if not @valid
      flash[:error] = @ecard.errors.full_messages.join "<br>"
      redirect_to send_ecard_path
    else
      flash[:notice] = "Yay! Your E-card has been sent"
      @ecard.save
      redirect_to send_path
    end
  end
  
  def postcard_new
    @user = User.find_by_id(session[:userid])
    if @user.nil?
      flash[:error] = "You must be logged in to send postcards. <a href=\"#{register_path}\">Register here</a>"
      redirect_to login_path
      return
    elsif not @user.can_send_postcard
      flash[:error] = "You've already reached the limit of two postcards per year. <a href=\"#{send_ecard_path}\">Send an ecard instead</a>"
      redirect_to send_path
      return
    end
    @recent = @user.get_recent_postcards(SendController::RECENT_COUNT);
    render "postcard"
  end
  
  def postcard_create
    @user = User.find_by_id(session[:userid])
    if @user.nil?
      flash[:error] = "You must be logged in to send postcards. <a href=\"#{register_path}\">Register here</a>"
      redirect_to login_path
      return
    elsif not @user.can_send_postcard
      flash[:error] = "You've already reached the limit of two postcards per year. <a href=\"#{send_ecard_path}\">Send an ecard instead</a>"
      redirect_to send_path
      return
    end
    @postcard = Postcard.new params[:card]
    @valid = @postcard.valid?
    if not @valid
      flash[:error] = @postcard.errors.full_messages.join "<br>"
      redirect_to send_postcard_path
    else
      flash[:notice] = "Yay! Your postcard has been sent"
      @postcard.save
      redirect_to send_path
    end
  end
  
end


# POST:
# check:
# logged in?
# for postcards: User.can_send_postcard; can't send postcards at all if not logged in.
#
#
# save Card > Ecard Postcard....
#		date
#		name of person
#		address
#		message
#	
#	send the card!
#
#
# 
#
# User.get_recent_ecards(num of recent ecards)
#  '' '''' postcards( '''' )
#
# 
