# frozen_string_literal: true
# Course
class Course < ApplicationRecord
  has_many :storages
  has_many :course_preferences
  accepts_nested_attributes_for :course_preferences

  validates :title, presence: true

  default_scope { where(deleted: false) }
end
