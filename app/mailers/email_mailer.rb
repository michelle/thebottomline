class EmailMailer < ActionMailer::Base 
  def test_email 
    mail(:to => 'koolnerd103@gmail.com', :from => 'signthebottomline@gmail.com', :subject => "Forgot Password The Bottom Line", :message => "It should get delivered to recipient inbox" )
  end 
end
