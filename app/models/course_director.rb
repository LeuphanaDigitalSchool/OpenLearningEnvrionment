# frozen_string_literal: true
# Teacher
class CourseDirector < User
  validates :firstname, :lastname, presence: true

  default_scope { where(role: 4) }
end
