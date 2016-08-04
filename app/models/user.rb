# frozen_string_literal: true
# User
class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :email, presence: true
  validates :data_privacy, :terms_and_conditions, :honor_code, acceptance: true, if: proc { |u| u.role.zero? }
end
