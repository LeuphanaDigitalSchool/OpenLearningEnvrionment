# frozen_string_literal: true
FactoryGirl.define do
  sequence :email do |n|
    "testing#{n}@email.test"
  end

  factory :user do
    email
    password                'FakePassword123'
    password_confirmation   'FakePassword123'
    language                'en'
  end
end
