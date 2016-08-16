# frozen_string_literal: true
# CourseManager
class CourseManager < User
  validates :firstname, :lastname, presence: true

  default_scope { where(role_id: 6, deleted: false) }
end
