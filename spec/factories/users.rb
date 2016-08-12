# frozen_string_literal: true
FactoryGirl.define do
  sequence :email do |n|
    "user_#{n}@example.com"
  end

  factory :user do
    firstname               'Jola'
    lastname                'Mis'
    gender                  '1'
    country                 'PL'
    birthdate               '1998-01-01'
    email
    password                'FakePassword123'
    password_confirmation   'FakePassword123'
    avatar                  'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7'
    language                'en'
    terms_and_conditions    'true'
    data_privacy            'true'
  end

  trait :public_user do
    role_id '1'
  end

  trait :student do
    role_id '2'
  end

  trait :support do
    role_id '3'
  end

  trait :teacher do
    role_id '4'
  end

  trait :course_director do
    role_id '5'
  end

  trait :course_manager do
    role_id '6'
  end
end
