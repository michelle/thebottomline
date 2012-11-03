class UserMailer < ActionMailer::Base
  default from: "signthebottomline@gmail.com"

  def register_email(user)
    @user = user
    @url  = "http://thebottomline.herokuapp.com/" + login_path
    mail(:to => user.email, :subject => "Check out WhatsUpYourButt")
  end

  def password_change(user,random_password)
    @user = user
    @url  = "http://thebottomline.herokuapp.com/" + login_path
    @random_password = random_password
    mail(:to => user.email, 
         :subject => "Forgot Password The Bottom Line", 
         :content_type => 'text/html')
  end
end
