# frozen_string_literal: true
# Storage
class Storage < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :type, presence: true
end
