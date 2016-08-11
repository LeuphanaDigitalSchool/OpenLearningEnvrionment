# frozen_string_literal: true
# Course
class Course < ApplicationRecord
  validates :title, presence: true
end
