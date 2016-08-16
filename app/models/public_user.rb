# frozen_string_literal: true
# PublicUser
class PublicUser < User
  validates :data_privacy, :terms_and_conditions, acceptance: true

  default_scope { where(role_id: 1, deleted: false) }
end
