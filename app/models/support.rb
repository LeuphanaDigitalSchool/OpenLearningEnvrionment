# frozen_string_literal: true
# Support
class Support < User
  validates :firstname, :lastname, presence: true

  default_scope { where(role_id: 3, deleted: false) }
end
