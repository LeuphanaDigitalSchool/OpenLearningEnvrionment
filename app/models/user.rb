# frozen_string_literal: true
# User
class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable, :invitable
  include DeviseTokenAuth::Concerns::User
  acts_as_messageable

  belongs_to :role
  has_many :storages

  mount_base64_uploader :avatar, UserAvatarUploader

  validates :email, presence: true
  validates :data_privacy, :terms_and_conditions, acceptance: true, if: proc { |u| u.role_id == 1 }

  enum gender_options: [:male, :female, :not_say]
  enum educational_attainment_options: [:notsay, :highschool, :bechelor, :master, :phd, :professor]
  enum role_options: [:public_user, :student, :support, :teacher, :course_director, :course_manager]

  default_scope { where(deleted: false).order(invitation_token: :asc, role_id: :asc) }
  scope :participants, -> { where(invitation_token: nil) }

  def gender_options_json
    genders = []
    User.gender_options.each { |k, v| genders.push(name: k, value: v) }
    genders
  end

  def educational_attainment_options_json
    educational_attainments = []
    User.educational_attainment_options.each { |k, v| educational_attainments.push(name: k, value: v) }
    educational_attainments
  end

  def role_options_json
    roles = []
    User.role_options.each { |k, v| roles.push(name: k, value: v) }
    roles
  end

  def age
    check_age unless birthdate.nil?
  end

  def mailboxer_email(_messageable)
    email
  end

  def display_name
    "#{firstname} #{lastname}" || email
  end

  protected

  def password_required?
    false
  end

  private

  def check_age
    today = Date.today
    d = Date.new(today.year, birthdate.month, birthdate.day)
    d.year - birthdate.year - (d > today ? 1 : 0)
  end
end

# 1 public user
# 2 student
# 3 support
# 4 teacher
# 5 course director
# 6 course manager
# avatar example # data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7
