require 'csv'
require 'time'

class Postcard < ActiveRecord::Base
  belongs_to :user
  @@last_sent_file_path = "tmp/last_sent_postcard_csv"
  @@csv_file_path = "tmp/postcards.csv"

  def self.send_postcard_csv
    if create_postcard_csv()
      PostcardMailer.send_csv(@@csv_file_path).deliver
      #delete csv file
      File.delete(@@csv_file_path)
    end
  end

  #creates the csv file if there are postcards to send, returning true if the file is created successfully
  def self.create_postcard_csv
    last_sent_time = find_last_sent_time()
    new_sent_time = Time.now
    postcards_to_send =  Postcard.all(:conditions => ["created_at > ? and created_at <= ?", last_sent_time, new_sent_time])
    if postcards_to_send.length != 0
      #generate csv file
      CSV.open(@@csv_file_path, "wb") do |csv|
        #header
        csv << ["Name", "Address", "City", "State", "Zip Code"]
        #add all postcards since last send
        postcards_to_send.each do |postcard|
          name = postcard.recipient
          address = postcard.address_street
          city = postcard.address_city
          state = postcard.address_state
          zip = postcard.address_zip
          csv << [name, address, city, state, zip]
        end
      end
      file_created = true
    else
      file_created = false
    end
    update_last_sent_time(new_sent_time)
    return file_created
  end

  def self.find_last_sent_time
    if not File.exist? @@last_sent_file_path
      File.open(@@last_sent_file_path, "w") do |file|
        file.write(Time.at(0).to_f)
      end
    end
    file = File.open(@@last_sent_file_path, "r")
    last_sent_time = Time.at(file.read.to_f)
    file.close()
    return last_sent_time
  end

  def self.update_last_sent_time(time)
    File.open(@@last_sent_file_path, "w") do |file|
        file.write(time.to_f)
    end
  end

end
