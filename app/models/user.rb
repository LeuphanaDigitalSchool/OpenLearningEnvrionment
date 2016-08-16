# frozen_string_literal: true
# User
class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable, :invitable
  include DeviseTokenAuth::Concerns::User
  acts_as_messageable

  belongs_to :role

  mount_base64_uploader :avatar, UserAvatarUploader

  has_many :storages

  validates :email, presence: true
  validates :data_privacy, :terms_and_conditions, acceptance: true, if: proc { |u| u.role_id.zero? }

  enum gender_options: [:male, :female]
  enum educational_attainment_options: [:nope, :highschool, :bechelor, :master, :phd, :professor]
  enum role_options: [:public_user, :student, :support, :teacher, :course_director, :course_manager]

  def age
    ((Date.today - birthdate).to_i / 365) if birthdate.present?
  end

  def mailboxer_email(_messageable)
    email
  end

  def display_name
    "#{firstname} #{lastname}" || email
  end
end

# 1 public user
# 2 student
# 3 support
# 4 teacher
# 5 course director
# 6 course manager
