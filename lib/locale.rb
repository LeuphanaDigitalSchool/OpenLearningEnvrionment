# frozen_string_literal: true
# Locale
module Locale
  extend ActiveSupport::Concern

  included do
    before_action :language
  end

  def language
    I18n.locale = lang_by_params || lang_by_user_settings || lang_by_browser_language || I18n.default_locale
    response.headers['User-Language'] = I18n.locale
  end

  private

  def lang_by_params
    params[:lang] if params[:lang]
  end

  def lang_by_user_settings
    current_api_v1_user.language if api_v1_user_signed_in?
  end

  def lang_by_browser_language
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first if request.env['HTTP_ACCEPT_LANGUAGE']
  end
end
