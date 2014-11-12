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
end