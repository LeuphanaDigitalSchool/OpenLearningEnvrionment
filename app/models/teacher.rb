# frozen_string_literal: true
# Teacher
class Teacher < User
  validates :firstname, :lastname, presence: true

  default_scope { where(role: 3, deleted: false) }
end
