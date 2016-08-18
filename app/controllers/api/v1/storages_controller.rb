# frozen_string_literal: true
module Api
  module V1
    # Api::V1::StorageController
    class StoragesController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_storage, only: [:show, :update, :destroy]

      def index
        course = Course.find(params[:course_id])
        storages = course.storages
        render json: storages, status: :ok
      end

      def create
        course = Course.find(params[:course_id])
        storage = course.storages.build(storage_params)
        storage.user = current_api_v1_user

        if storage.save
          render json: storage, status: :created
        else
          render json: storage.errors, status: :unprocessable_entity
        end
      end

      def show
        render json: @storage, status: :ok
      end

      def update
        if @storage.update(storage_params)
          render json: @storage, status: :ok
        else
          render json: @storage.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @storage.update(deleted: true)
          render json: nil, status: :no_content
        else
          render json: @storage.errors, status: :unprocessable_entity
        end
      end

      private

      def storage_params
        params.require(:storage).permit(:user_id, :course_id, :source, :name, :file, :description, :url, :deleted)
      end

      def set_storage
        @storage = Storage.find(params[:id])
      end
    end
  end
end
