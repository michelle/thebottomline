require 'spec_helper'
 
describe NewsletterMailer do
  describe 'ecard sending' do
    
    subject = "x"
    body = "y"
    
    let(:user) { mock_model(User, :email => 'x@x.com') }
    let(:mail) { NewsletterMailer.newsletter_email(user, subject, body) }
 
    #ensure that the subject is correct
    it 'renders the subject' do
      mail.subject.should == subject
    end
 
    #ensure that the receiver is correct
    it 'renders the receiver email' do
      mail.to.should == [user.email]
    end
 
    #ensure that the sender is correct
    it 'renders the sender email' do
      mail.from.should == ["signthebottomline@gmail.com"]
    end
 
    #ensure that the @ecard variable appears in the email newsletter_email
    it 'assigns body values' do
      mail.body.encoded.should match(body)
      mail.body.encoded.should match(user.email)
    end
  end
  
end
