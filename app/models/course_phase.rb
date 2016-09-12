# frozen_string_literal: true
# CoursePhase
class CoursePhase < ApplicationRecord
  belongs_to :course
  has_and_belongs_to_many :storages
  has_many :course_phase_preferences
  accepts_nested_attributes_for :course_phase_preferences

  default_scope { order(id: :asc, start_date: :asc) }
  scope :active, -> { where('? > start_date AND end_date > ?', Time.now, Time.now).first }

  validates :title, presence: true
end
