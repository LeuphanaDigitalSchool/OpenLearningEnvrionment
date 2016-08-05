# frozen_string_literal: true
FactoryGirl.define do
  sequence :email do |n|
    "user_#{n}@example.com"
  end

  factory :user do
    email
    password                'FakePassword123'
    password_confirmation   'FakePassword123'
    avatar                  'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7'
    language                'en'
    honor_code              'true'
    terms_and_conditions    'true'
    data_privacy            'true'
  end

  trait :public_user do
    role '0'
  end

  trait :student do
    role '1'
  end

  trait :support do
    role '2'
  end

  trait :teacher do
    role '3'
  end

  trait :course_director do
    role '4'
  end

  trait :course_manager do
    role '5'
  end
end
