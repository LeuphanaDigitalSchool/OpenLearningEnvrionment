# frozen_string_literal: true
# Role
class Role < ApplicationRecord
  has_many :users
  has_and_belongs_to_many :permissions
end
