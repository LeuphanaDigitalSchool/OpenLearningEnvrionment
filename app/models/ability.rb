# frozen_string_literal: true
# Ability
class Ability
  include CanCan::Ability

  def initialize(user)
    user.role.permissions.each do |permission|
      can permission.action.to_sym, model_access(permission)
    end
  end

  private

  def model_access(permission)
    permission.subject_class == 'all' ? permission.subject_class.to_sym : permission.subject_class.constantize
  end
end