# frozen_string_literal: true
FactoryGirl.define do
  factory :course do
    title 'Example course'
    description 'Course description'
    start_date '2016-08-11'
    end_date '2017-08-11'
  end
end
