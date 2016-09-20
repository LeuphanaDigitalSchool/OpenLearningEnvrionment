# frozen_string_literal: true
# ApplicationController
class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Serialization
  include CanCan::ControllerAdditions
  include Locale

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |_exception|
    render json: { error: 'Access denied.' }, status: :unauthorized
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:title, :firstname, :lastname, :data_privacy,
                                                       :terms_and_conditions, :honor_code])
    devise_parameter_sanitizer.permit(:accept_invitation) do |u|
      u.permit(:password, :password_confirmation, :interests, :gender, :title, :country, :educational_attainment,
               :avatar, :data_privacy, :terms_and_conditions, :honor_code, :birthdate, :profession, :introduction)
    end
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :password, :password_confirmation,
                                                              :interests, :gender, :title, :country,
                                                              :educational_attainment, :avatar, :remove_avatar,
                                                              :data_privacy, :terms_and_conditions, :honor_code,
                                                              :birthdate, :profession, :introduction])
  end

  def current_ability
    @current_ability ||= Ability.new(current_api_v1_user)
  end

  def load_permissions
    @current_permissions = current_api_v1_user.role.permissions.collect { |i| [i.subject_class, i.action] }
  end
end
