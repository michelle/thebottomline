scheduler = Rufus::Scheduler.start_new

scheduler.every("2w") do
  Postcard.send_postcard_csv
end
