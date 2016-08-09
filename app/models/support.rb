# frozen_string_literal: true
# Support
class Support < User
  validates :firstname, :lastname, presence: true

  default_scope { where(role: 2, deleted: false) }
end
