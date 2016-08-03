# frozen_string_literal: true
module Api
  module V1
    # Api::V1::LocalesController
    class LocalesController < ApplicationController
      before_action :save_user_language

      def index
        response.headers['User-Language'] = I18n.locale
        yml = YAML.load_file("config/locales/front.#{I18n.locale}.yml")
        render json: yml[I18n.locale.to_s].to_json
      end

      private

      def save_user_language
        if api_v1_user_signed_in? && params[:lang] && I18n.available_locales.include?(params[:lang].to_sym)
          current_api_v1_user.update(language: params[:lang])
        end
      end
    end
  end
end
