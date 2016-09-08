# frozen_string_literal: true
# Storage
class Storage < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :course_phases

  mount_base64_uploader :file, StorageUploader

  validates :source, presence: true

  default_scope { where(deleted: false) }

  def upload_whitelist
    # binding.pry
    # allow = course_phase.find(course_phase_id).course_phase_preferences.find_by(role_id: user.role_id)
    # whitelist = []
    # whitelist.push('pdf') if allow.upload_pdf
    # whitelist.push('jpg') if allow.upload_jpg
    # whitelist.push('mp3') if allow.upload_mp3
    # whitelist.push('mp4') if allow.upload_mp4
    %w(pdf jpg mp3 mp4)
  end
end
