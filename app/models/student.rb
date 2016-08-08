# frozen_string_literal: true
# Student
class Student < User
  validates :firstname, :lastname, :gender, :country, :age, presence: true
  validates :data_privacy, :terms_and_conditions, :honor_code, acceptance: true

  default_scope { where(role: 1) }
end
