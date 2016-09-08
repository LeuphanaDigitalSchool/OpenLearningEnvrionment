# frozen_string_literal: true
# CoursePhase
class CoursePhase < ApplicationRecord
  belongs_to :course
  has_many :storages
  has_many :course_phase_preferences
  accepts_nested_attributes_for :course_phase_preferences

  default_scope { order(id: :asc, start_date: :asc) }

  validates :title, presence: true
end
