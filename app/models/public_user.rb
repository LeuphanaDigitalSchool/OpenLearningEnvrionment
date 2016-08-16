# frozen_string_literal: true
# PublicUser
class PublicUser < User
  default_scope { where(role_id: 1, deleted: false) }
  validates :data_privacy, :terms_and_conditions, acceptance: true
end
