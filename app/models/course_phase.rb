# frozen_string_literal: true
# CoursePhase
class CoursePhase < ApplicationRecord
  belongs_to :course
  has_and_belongs_to_many :storages
  has_many :course_phase_preferences, dependent: :destroy
  accepts_nested_attributes_for :course_phase_preferences

  validates :title, presence: true
  validates :start_date, :end_date, presence: true

  default_scope { order(id: :asc, start_date: :asc) }
  scope :active, -> { where('? >= start_date AND end_date >= ?', DateTime.now.to_date, DateTime.now.to_date).first }

  before_save :prepare_correct_start_date, :prepare_correct_end_date

  def prepare_correct_start_date
    self.start_date = Time.parse('16:00:00', Time.parse(start_date.to_s))
  end

  def prepare_correct_end_date
    self.end_date = Time.parse('15:59:59', Time.parse(end_date.to_s))
  end
end
