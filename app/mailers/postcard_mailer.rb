class PostcardMailer < ActionMailer::Base
  default from: "signthebottomline@gmail.com"

  def send_csv(path_to_file,email = "info@signthebottomline.org")
    attachments["postcards.csv"] = File.read(path_to_file)
 
    mail(:to => email,
         :subject => "You got unsent postcards!")
  end
end
