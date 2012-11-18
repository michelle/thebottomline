require 'csv'
require 'time'

class Postcard < ActiveRecord::Base
  belongs_to :user
  @@last_sent_file_path = "tmp/last_sent_postcard_csv"
  @@csv_file_path = "tmp/postcards.csv"

  def self.send_postcard_csv
    create_postcard_csv()
    PostcardMailer.send_csv(@@csv_file_path).deliver
    #delete csv file
    File.delete(@@csv_file_path)
  end

  def self.create_postcard_csv
    #generate csv file
    CSV.open(@@csv_file_path, "wb") do |csv|
      #header
      csv << ["Name", "Address", "City", "State", "Zip Code"]
      #add all postcards since last send
      last_sent_time = find_last_sent_time()
      new_sent_time = Time.now
      Postcard.all(:conditions => ["created_at > ? and created_at <= ?", last_sent_time, new_sent_time]).each do |postcard|
        name = postcard.recipient
        address = postcard.address_street
        city = postcard.address_city
        state = postcard.address_state
        zip = postcard.address_zip
        csv << [name, address, city, state, zip]
      end
      update_last_sent_time(new_sent_time)
    end
  end

  def self.find_last_sent_time
    if not File.exist? @@last_sent_file_path
      File.open(@@last_sent_file_path, "w") do |file|
        file.write(Time.at(0).to_s)
      end
    end
    file = File.open(@@last_sent_file_path, "r")
    last_sent_time = Time.parse(file.read)
    file.close()
    return last_sent_time
  end

  def self.update_last_sent_time(time)
    File.open(@@last_sent_file_path, "w") do |file|
        file.write(time.to_s)
    end
  end

end
