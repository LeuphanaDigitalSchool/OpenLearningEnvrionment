# frozen_string_literal: true
# Storage
class Storage < ApplicationRecord
  belongs_to :user
  belongs_to :course

  mount_base64_uploader :file, StorageUploader

  validates :source, presence: true

end
