# frozen_string_literal: true
# User
class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  mount_base64_uploader :avatar, UserAvatarUploader

  validates :email, presence: true
  validates :data_privacy, :terms_and_conditions, acceptance: true, if: proc { |u| u.role.zero? }

  enum gender_options: [:male, :female]
  enum educational_attainment_options: [:nope, :highschool, :bechelor, :master, :phd, :professor]
  enum role_options: [:public_user, :student, :support, :teacher, :course_director, :course_manager]

  def age
    ((Date.today - birthdate).to_i / 365) if birthdate.present?
  end
end

# 0 public user
# 1 student
# 2 support
# 3 teacher
# 4 course director
# 5 course manager
