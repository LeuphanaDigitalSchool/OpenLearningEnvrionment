# frozen_string_literal: true
# Storage
class Storage < ApplicationRecord
  belongs_to :user
  belongs_to :course

  mount_base64_uploader :file, StorageUploader

  validates :source, presence: true

  default_scope { where(deleted: false) }

  def upload_whitelist
    allow = course.course_preferences.find_by(role_id: user.role_id)
    whitelist = []
    whitelist.push('pdf') if allow.upload_pdf
    whitelist.push('jpg') if allow.upload_jpg
    whitelist.push('mp3') if allow.upload_mp3
    whitelist.push('mp4') if allow.upload_mp4
    whitelist
  end
end
