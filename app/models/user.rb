# frozen_string_literal: true
# User
class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :email, presence: true
  validates :data_privacy, :terms_and_conditions, :honor_code, acceptance: true, if: proc { |u| u.role.zero? }

  enum gender_options: [:male, :female]
  enum educational_attainment_options: [:nope, :highschool, :bechelor, :master, :phd, :professor]
end

# 0 public user
# 1 student
# 2 support
# 3 teacher
# 4 course director
# 5 course manager
