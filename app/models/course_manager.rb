# frozen_string_literal: true
# CourseManager
class CourseManager < User
  validates :firstname, :lastname, presence: true

  default_scope { where(role: 5) }
end
