# frozen_string_literal: true
module Api
  module V1
    module Admin
      module Users
        # Api::V1::Admin::Users::PublicUsersController
        class PublicUsersController < ApplicationController
          before_action :authenticate_api_v1_user!

          def index
            public_users = PublicUser.all
            render json: public_users, status: :ok
          end
        end
      end
    end
  end
end
