# frozen_string_literal: true
# CoursePreference
class CoursePreference < ApplicationRecord
  belongs_to :course
  belongs_to :role

  def upload_preferences
    upload_pdf || upload_jpg || upload_mp3 || upload_mp4 ? true : false
  end
end
