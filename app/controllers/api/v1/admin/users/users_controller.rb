# frozen_string_literal: true
module Api
  module V1
    module Admin
      module Users
        # Api::V1::Admin::Users::UsersController
        class UsersController < ApplicationController
          before_action :authenticate_api_v1_user!

          def index
            users = User.where(deleted: false)
            render json: users, status: :ok
          end

          def profile_selects
            json = { genders: User.new.gender_options_json,
                     educational_attainments: User.new.educational_attainment_options_json }
            render json: json, status: :ok
          end
        end
      end
    end
  end
end
