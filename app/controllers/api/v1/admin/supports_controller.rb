# frozen_string_literal: true
module Api
  module V1
    module Admin
      # Api::V1::Admin::SupportsController
      class SupportsController < ApplicationController
        before_action :authenticate_api_v1_user!

        def index
          supports = Support.all
          render json: supports, status: :ok
        end

        def create
          support = Support.new(support_params)

          if support.save
            render json: support, status: :created
          else
            render json: support.errors, status: :unprocessable_entity
          end
        end

        private

        def support_params
          params.require(:support).permit(:title, :firstname, :lastname, :gender, :country, :birthdate, :profession,
                                          :educational_attainment, :avatar, :interests, :introduction, :email,
                                          :password, :password_confirmation)
        end
      end
    end
  end
end
