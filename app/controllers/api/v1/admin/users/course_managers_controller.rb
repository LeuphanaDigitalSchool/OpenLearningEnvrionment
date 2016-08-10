# frozen_string_literal: true
module Api
  module V1
    module Admin
      module Users
        # Api::V1::Admin::Users::CourseManagersController
        class CourseManagersController < ApplicationController
          before_action :authenticate_api_v1_user!
          before_action :set_course_manager, only: [:show, :update, :destroy]

          def index
            course_managers = CourseManager.all
            render json: course_managers, status: :ok
          end

          def create
            course_manager = CourseManager.new(course_manager_params)

            if course_manager.save
              course_manager.invite!(current_api_v1_user)
              render json: course_manager, status: :created
            else
              render json: course_manager.errors, status: :unprocessable_entity
            end
          end

          def show
            render json: @course_manager, status: :ok
          end

          def update
            if @course_manager.update(course_manager_params)
              render json: @course_manager, status: :ok
            else
              render json: @course_manager.errors, status: :unprocessable_entity
            end
          end

          def destroy
            if @course_manager.update(deleted: true)
              render json: nil, status: :no_content
            else
              render json: @course_manager.errors, status: :unprocessable_entity
            end
          end

          private

          def course_manager_params
            params.require(:course_manager).permit(:title, :firstname, :lastname, :gender, :country, :birthdate,
                                                   :profession, :educational_attainment, :avatar, :interests,
                                                   :introduction, :email, :password, :password_confirmation)
          end

          def set_course_manager
            @course_manager = CourseManager.find(params[:id])
          end
        end
      end
    end
  end
end
