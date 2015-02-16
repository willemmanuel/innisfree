FactoryGirl.define do  factory :recurring_reminder do
    appointment_id ""
notification_date "2015-02-09"
  end


  factory :user do
    name 'Test User'
    email 'test@example.com'
    password 'please123'
    approved true
    admin true
  end

  factory :car do
    name 'Civic'
  end

  factory :appointment do
    resident_id 1
    doctor_id 1
    date Date.new(2014, 10, 5)
    time '2014-10-05 12:06:26'
  end

  factory :house do
    name 'Test'
  end

  factory :resident do
    name 'John Doe'
    house_id 1
  end

  factory :doctor do
    name 'Doctor #1'
    address '123 University Drive'
    phone '123456'
  end
end
