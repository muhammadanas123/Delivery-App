FactoryBot.define do
  factory :user do
    email { "umer1@example.com" }
    password { "password" }
    firstname { "anas" }
    lastname { "farooqi" }
    phone_no { 13332221111 }
    landline { 13331112222 }
    city { "lahore" }
    state { "punjab" }
    country { "pakistan" }
  end
end
