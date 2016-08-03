# frozen_string_literal: true
# User
class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :recoverable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :email, presence: true
end
