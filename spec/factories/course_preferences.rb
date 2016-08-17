# frozen_string_literal: true
FactoryGirl.define do
  factory :course_preference do
    course nil
    role nil
    upload_pdf false
    upload_jpg false
    upload_mp3 false
    upload_mp4 false
    add_resources_description false
    del_resources_description false
    schedule_publishing false
  end
end
