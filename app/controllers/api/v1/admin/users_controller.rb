# frozen_string_literal: true
module Api
  module V1
    module Admin
      # Api::V1::Admin::UsersController
      class UsersController < ApplicationController
        before_action :authenticate_api_v1_user!

        def profile_selects
          json = { genders: User.gender_options, educational_attainments: User.educational_attainment_options }
          render json: json, status: :ok
        end
      end
    end
  end
end
