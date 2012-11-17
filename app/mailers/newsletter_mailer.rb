class NewsletterMailer < ActionMailer::Base
  default from: "signthebottomline@gmail.com"

  def send_newsletter(user, text)
    @user = user
    @text = text
    mail(:to => user.email, 
         :subject => "The Bottom Line Newsletter", 
         :content_type => 'text/html')
  end

end
