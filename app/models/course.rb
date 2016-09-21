# frozen_string_literal: true
# Course
class Course < ApplicationRecord
  has_many :storages
  has_many :course_phases, dependent: :destroy
  accepts_nested_attributes_for :course_phases, limit: 6

  validates :title, presence: true
  validates :start_date, :end_date, presence: true

  default_scope { where(deleted: false) }

  before_save :prepare_correct_start_date, :prepare_correct_end_date

  def prepare_correct_start_date
    self.start_date = Time.parse('16:00:00', Time.parse(start_date.to_s))
  end

  def prepare_correct_end_date
    self.end_date = Time.parse('15:59:59', Time.parse(end_date.to_s))
  end
end
