require 'spec_helper'
 
describe PostcardMailer do
  describe 'sending Admin unsent postcard addresses' do
    
    let(:mail) { PostcardMailer.send_csv("test/fixtures/testfile.csv", "koolnerd103@gmail.com") }
 
    #ensure that the subject is correct
    it 'renders the subject' do
      mail.subject.should == "You got unsent postcards!"
    end
 
    #ensure that the receiver is correct
    it 'renders the receiver email' do
      mail.to.should == ["koolnerd103@gmail.com"]
    end
 
    #ensure that the sender is correct
    it 'renders the sender email' do
      mail.from.should == ["signthebottomline@gmail.com"]
    end
 
    #ensure that the attachment is there
    it 'attaches the file to the email' do
      mail.has_attachments?.should == true
      mail.attachments.first.filename.should == "postcards.csv"
      mail.attachments.first.content_type.should == "text/csv; filename=postcards.csv"
      mail.attachments.first.body.should == File.read("test/fixtures/testfile.csv")
    end
  end
  
end
