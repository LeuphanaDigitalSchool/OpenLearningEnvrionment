# frozen_string_literal: true
module Api
  module V1
    module Admin
      module Users
        # Api::V1::Admin::Users::PublicUsersController
        class PublicUsersController < ApplicationController
          before_action :authenticate_api_v1_user!
          before_action :set_public_user, only: [:show]

          def index
            public_users = PublicUser.all
            render json: public_users, status: :ok
          end

          def show
            render json: @public_user, status: :ok
          end

          private

          def set_public_user
            @public_user = PublicUser.find(params[:id])
          end
        end
      end
    end
  end
end
