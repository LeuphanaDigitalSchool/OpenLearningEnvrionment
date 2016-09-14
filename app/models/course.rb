# frozen_string_literal: true
# Course
class Course < ApplicationRecord
  has_many :storages
  has_many :course_phases, dependent: :destroy
  accepts_nested_attributes_for :course_phases, limit: 6

  validates :title, presence: true
  validates :start_date, :end_date, presence: true

  default_scope { where(deleted: false) }
end
