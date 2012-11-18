class NewsletterMailer < ActionMailer::Base
  default from: "signthebottomline@gmail.com"

  def newsletter_broadcast(user, subject, body)
    @body = body
    mail(:to => user.email, 
         :subject => subject,
         :content_type => 'text/html')
  end
end
