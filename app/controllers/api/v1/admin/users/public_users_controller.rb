# frozen_string_literal: true
module Api
  module V1
    module Admin
      module Users
        # Api::V1::Admin::Users::PublicUsersController
        class PublicUsersController < ApplicationController
          before_action :authenticate_api_v1_user!
          before_action :set_public_user, only: [:show, :update, :destroy]

          def index
            public_users = PublicUser.all
            render json: public_users, status: :ok
          end

          def show
            render json: @public_user, status: :ok
          end

          def update
            if @public_user.update(public_user_params)
              render json: @public_user, status: :ok
            else
              render json: @public_user.errors, status: :unprocessable_entity
            end
          end

          def destroy
            if @public_user.update(deleted: true)
              render json: nil, status: :no_content
            else
              render json: @public_user.errors, status: :unprocessable_entity
            end
          end

          private

          def public_user_params
            params.require(:public_user).permit(:firstname, :lastname, :gender, :country, :birthdate, :avatar,
                                                :interests, :introduction, :email, :password, :password_confirmation)
          end

          def set_public_user
            @public_user = PublicUser.find(params[:id])
          end
        end
      end
    end
  end
end
