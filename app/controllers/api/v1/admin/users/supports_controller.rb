# frozen_string_literal: true
module Api
  module V1
    module Admin
      module Users
        # Api::V1::Admin::Users::SupportsController
        class SupportsController < ApplicationController
          before_action :authenticate_api_v1_user!
          before_action :set_support, only: [:show]

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

          def show
            render json: @support, status: :ok
          end

          private

          def support_params
            params.require(:support).permit(:title, :firstname, :lastname, :gender, :country, :birthdate, :profession,
                                            :educational_attainment, :avatar, :interests, :introduction, :email,
                                            :password, :password_confirmation)
          end

          def set_support
            @support = Support.find(params[:id])
          end
        end
      end
    end
  end
end
