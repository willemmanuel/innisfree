FactoryGirl.define do  

  factory :recurring_reminder do
    appointment_id ""
    notification_date "2015-02-09"
  end

  factory :car do
    name 'Civic'
  end

  factory :appointment do
    resident
    doctor
    date Date.tomorrow
    time '12:06:26'
    apt_type 
  end

  factory :house do
    name 'Workstations'
  end

  factory :house2, class: House do
    name 'Workstations'
  end
  
  factory :user do
    name 'Test User'
    email 'test@example.com'
    password 'please123'
    approved true
    admin true
  end

  factory :otheruser, class: User do
    name 'Testy User'
    email 'test1@example.com'
    password 'please123'
    approved true
    admin true
  end

  factory :resident do
    name 'John Doe'
    house
  end

  factory :reservation do
    user
    car
    start Time.zone.now + 2.hour
    finish Time.zone.now + 3.hour
  end

  factory :doctor do
    name 'Doctor #1'
    address '123 University Drive'
    phone '123456'
  end

  factory :apt_type  do
    id 1
    apt_type 'type'
  end
end
