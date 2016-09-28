# frozen_string_literal: true
# Regulation
class Regulation < ApplicationRecord
  mount_base64_uploader :file, RegulationUploader

  validates :file, presence: true
end
