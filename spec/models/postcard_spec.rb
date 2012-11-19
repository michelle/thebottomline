require 'spec_helper'

describe Postcard do
  LAST_SENT_TEST_FILE_PATH = "tmp/last_sent_postcard_csv_test"
  CSV_TEST_FILE_PATH = "tmp/postcards_test.csv"

  before(:each) do
    Postcard.class_variable_set :@@last_sent_file_path, LAST_SENT_TEST_FILE_PATH
    Postcard.class_variable_set :@@csv_file_path, CSV_TEST_FILE_PATH
    ActionMailer::Base.deliveries = []
  end
  after(:each) do
    if File.exists? LAST_SENT_TEST_FILE_PATH
      File.delete(LAST_SENT_TEST_FILE_PATH)
    end
    if File.exists? CSV_TEST_FILE_PATH
      File.delete(CSV_TEST_FILE_PATH)
    end
  end

  describe 'has postcards to send' do
    before(:each) do
      @postcard = FactoryGirl.create(:postcard)
    end
    it 'should create the csv file' do
      Postcard.should_receive(:create_postcard_csv)
      Postcard.send_postcard_csv()
    end
    it 'should add @postcard to the csv file' do
      Postcard.create_postcard_csv()
      csv_rows = CSV.read(CSV_TEST_FILE_PATH)
      csv_rows[0][0].should == "Name"
      csv_rows[1][0].should == @postcard.recipient
    end
    it 'should send the csv file' do
      Postcard.send_postcard_csv()
      mail = ActionMailer::Base.deliveries.last
      mail.to.should == ["koolnerd103@gmail.com"]
      mail.subject.should == "You got unsent postcards!"
    end
    it 'should delete the csv file' do
      Postcard.send_postcard_csv()
      (File.exist? CSV_TEST_FILE_PATH).should == false
    end

    describe 'then has more postcards to send' do
      it 'should create the csv file without the previous postcards' do
        Postcard.send_postcard_csv()
        @postcard2 = FactoryGirl.create(:postcard,
                                        :recipient => "Some Other Recipient")
        Postcard.create_postcard_csv()
        csv_rows = CSV.read(CSV_TEST_FILE_PATH)
        csv_rows[1][0].should == @postcard2.recipient
      end
    end
  end

  describe 'no postcards to send' do
    it 'should not create a new csv file' do
      Postcard.create_postcard_csv
      (File.exists? CSV_TEST_FILE_PATH).should == false
    end
    it 'should not send anything' do
      Postcard.send_postcard_csv()
      ActionMailer::Base.deliveries.should be_empty
    end
  end
end
