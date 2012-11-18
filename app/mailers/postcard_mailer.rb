class PostcardMailer < ActionMailer::Base
  default from: "signthebottomline@gmail.com"

  def send_csv(path_to_file)
    attachments["postcards.csv"] = File.read(path_to_file)
 
    mail(:to => "koolnerd103@gmail.com",
         :subject => "You got unsent postcards!")
  end
end
