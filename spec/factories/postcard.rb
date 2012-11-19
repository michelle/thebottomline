FactoryGirl.define do
  factory :postcard do
    sender "Some Sender"
    recipient "Some Recipient"
    address_street "123 Fake St"
    address_city "Faketown"
    address_state "Fakestate"
    address_zip "12345"
    message ""
    background ""
  end
end
