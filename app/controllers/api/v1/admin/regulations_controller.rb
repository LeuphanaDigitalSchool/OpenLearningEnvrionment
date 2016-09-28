# frozen_string_literal: true
module Api
  module V1
    module Admin
      # Api::V1::RegulationsController
      class RegulationsController < ApplicationController
        before_action :authenticate_api_v1_user!, only: [:index, :update]
        before_action :set_regulations, only: [:show, :update]

        def index
          regulations = Regulation.all
          render json: regulations, status: :ok
        end

        def show
          render json: @regulation, status: :ok
        end

        def update
          if @regulation.update(regulation_params)
            render json: @regulation, status: :ok
          else
            render json: @regulation.errors, status: :unprocessable_entity
          end
        end

        private

        def regulation_params
          params.permit(:name, :file)
        end

        def set_regulations
          @regulation = Regulation.find(params[:id])
        end
      end
    end
  end
end
