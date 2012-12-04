class NewsletterMailer < ActionMailer::Base
  default from: "signthebottomline@gmail.com"

  def newsletter_email(user, subject, body)
    @msg = body
    @email = user.email
    mail(:to => user.email, 
         :subject => subject,
         :content_type => 'text/html')
  end
end
