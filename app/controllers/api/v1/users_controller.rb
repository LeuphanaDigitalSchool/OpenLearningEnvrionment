# frozen_string_literal: true
module Api
  module V1
    # Api::V1::UsersController
    class UsersController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_user, only: [:show]

      def show
        render json: @user, status: :ok
      end

      private

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
