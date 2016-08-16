# frozen_string_literal: true
# Course
class Course < ApplicationRecord
  has_many :storages

  validates :title, presence: true
end
