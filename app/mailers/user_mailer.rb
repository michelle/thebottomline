class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def register_email(user)
    @user = user
    @url  = "http://signthebottomline.org/" + login_path
    mail(:to => user.email, :subject => "Check out WhatsUpYourButt")
  end
end
