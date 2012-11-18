class NewsletterController < ApplicationController
  def send_newsletter
    @content = params[:content]
    @password = params[:password]
    @user = User.find(params[:user_id])
    if not @user.is_admin
      flash[:error] = "Only admins can send newsletters"
    elsif @content.empty?
      flash[:error] = "Silly you forgot the content!"
    elsif not User.correct_password?(@user, @password)
      flash[:error] = "Incorrect password"
    end
    if flash[:error]
      return redirect_to send_newsletter_path
    end
    User.send_newsletter_to_subscribers(@content)
    flash[:notice] = "Your newsletter has been sent!"
    redirect_to #to be determined...
  end
end
