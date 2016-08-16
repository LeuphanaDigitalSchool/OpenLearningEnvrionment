# frozen_string_literal: true
# Teacher
class CourseDirector < User
  validates :firstname, :lastname, presence: true

  default_scope { where(role_id: 5, deleted: false) }
end
