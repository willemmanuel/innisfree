FactoryGirl.define do
  factory :user do
    name "Test User"
    email "test@example.com"
    password "please123"
    approved true
    admin true
  end
  factory :car do
    name "Civic"
  end
  factory :appointment do
    resident_id 1 
    physician_id 1
    date Date.new(2014, 10, 5)
    time '2014-10-05 12:06:26'
  end
  factory :resident do
    name "John Doe"
    house_id 1
  end
end
