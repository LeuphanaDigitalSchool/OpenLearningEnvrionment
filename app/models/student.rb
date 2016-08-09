# frozen_string_literal: true
# Student
class Student < User
  validates :firstname, :lastname, :gender, :country, :birthdate, presence: true
  validates :data_privacy, :terms_and_conditions, acceptance: true

  default_scope { where(role: 1, deleted: false) }
end
