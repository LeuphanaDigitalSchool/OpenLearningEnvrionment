# frozen_string_literal: true
# User
class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :email, presence: true
  validates :data_privacy, :terms_and_conditions, :honor_code, acceptance: true, if: proc { |u| u.role.zero? }

  # GENDER 0 - MALE, 1 - FEMALE, 3 - I'D RATHER NOT SAY
  # EDUCATION_ATTAINMENT 0 - NONE, 1 - HIGHT SCHOLL, 2 - BECHELOR OR EQUIVALENT, 3 - MASTER OR EQUIVALENT, 4 - PhD,
  #                      5 - PROFESSOR
end

# 0 public user
# 1 student
# 2 support
# 3 teacher
# 4 course director
# 5 course manager
