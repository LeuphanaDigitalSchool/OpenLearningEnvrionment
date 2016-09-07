# frozen_string_literal: true
module Api
  module V1
    module Admin
      module Users
        # Api::V1::Admin::Users::UsersController
        class UsersController < ApplicationController
          before_action :authenticate_api_v1_user!, except: [:profile_selects]
          before_action :set_user, only: [:destroy]

          def index
            users = User.all
            render json: users, status: :ok
          end

          def destroy
            timestamp = Time.now.strftime('%Y%m%d%H%M%S')
            if @user.update(deleted: true, provider: "disable_#{timestamp}")
              render json: nil, status: :no_content
            else
              render json: @user.errors, status: :unprocessable_entity
            end
          end

          def profile_selects
            json = { genders: User.new.gender_options_json,
                     educational_attainments: User.new.educational_attainment_options_json }
            render json: json, status: :ok
          end

          private

          def set_user
            @user = User.find(params[:id])
          end
        end
      end
    end
  end
end
