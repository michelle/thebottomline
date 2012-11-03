class EcardMailer < ActionMailer::Base
  default from: "signthebottomline@gmail.com"

  def ecard_email(ecard)
    @ecard = ecard
    mail(:to => @ecard.address, 
         :subject => "Check out WhatsUpYourButt",
         :content_type => 'text/html')
  end
end
