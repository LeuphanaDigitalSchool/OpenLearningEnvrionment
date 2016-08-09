# frozen_string_literal: true
# PublicUser
class PublicUser < User
  default_scope { where(role: 0, deleted: false) }
end
