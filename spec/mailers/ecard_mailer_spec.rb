require 'spec_helper'
 
describe EcardMailer do
  describe 'ecard sending' do
    let(:ecard) { mock_model(Ecard, :sender => 'Eric',
                                    :recipient => 'Granny', 
                                    :address => 'koolgranny@email.com',
                                    :message => 'test!') }
    let(:mail) { EcardMailer.ecard_email(ecard) }
 
    #ensure that the subject is correct
    it 'renders the subject' do
      mail.subject.should == "Check out WhatsUpYourButt"
    end
 
    #ensure that the receiver is correct
    it 'renders the receiver email' do
      mail.to.should == [ecard.address]
    end
 
    #ensure that the sender is correct
    it 'renders the sender email' do
      mail.from.should == ["signthebottomline@gmail.com"]
    end
 
    #ensure that the @ecard variable appears in the email body
    it 'assigns @ecard values' do
      mail.body.encoded.should match(ecard.message)
      mail.body.encoded.should match(ecard.sender)
      mail.body.encoded.should match(ecard.recipient)
    end
  end
  
end
