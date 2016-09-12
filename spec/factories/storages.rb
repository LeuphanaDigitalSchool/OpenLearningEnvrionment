# frozen_string_literal: true
FactoryGirl.define do
  factory :storage do
    source 'Youtube'
    name 'Yt link'
    url 'https://www.youtube.com/watch?v=u_tORtmKIjE'
    course_phase_id 1
    user_id 1
  end
end
