require 'spec_helper'
 
describe UserMailer do
  describe 'register' do
    let(:user) { mock_model(User, :name => 'Granny', :email => 'koolgranny@email.com') }
    let(:mail) { UserMailer.register_email(user) }
 
    #ensure that the subject is correct
    it 'renders the subject' do
      mail.subject.should == "Check out WhatsUpYourButt"
    end
 
    #ensure that the receiver is correct
    it 'renders the receiver email' do
      mail.to.should == [user.email]
    end
 
    #ensure that the sender is correct
    it 'renders the sender email' do
      mail.from.should == ["signthebottomline@gmail.com"]
    end
 
    #ensure that the @url variable appears in the email body
    it 'assigns @url' do
      mail.body.encoded.should match("http://thebottomline.herokuapp.com/" + login_path)
    end
  end
  
  describe 'forgot password' do
    let(:user) { mock_model(User, :name => 'Granny', :email => 'koolgranny@email.com') }
    let(:mail) { UserMailer.password_change(user, "12345") }
 
    #ensure that the subject is correct
    it 'renders the subject' do
      mail.subject.should == "Forgot Password The Bottom Line"
    end
 
    #ensure that the receiver is correct
    it 'renders the receiver email' do
      mail.to.should == [user.email]
    end
 
    #ensure that the sender is correct
    it 'renders the sender email' do
      mail.from.should == ["signthebottomline@gmail.com"]
    end
 
    #ensure that the @url variable appears in the email body
    it 'assigns @url' do
      mail.body.encoded.should match("http://thebottomline.herokuapp.com/" + login_path)
    end
    
    #ensure that the @url variable appears in the email body
    it 'assigns @random_password' do
      mail.body.encoded.should match("12345")
    end
  end
end
