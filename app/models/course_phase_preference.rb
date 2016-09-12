# frozen_string_literal: true
# CoursePreference
class CoursePhasePreference < ApplicationRecord
  belongs_to :course_phase
  belongs_to :role

  def upload_preferences
    upload_pdf || upload_jpg || upload_mp3 || upload_mp4 ? true : false
  end
end
