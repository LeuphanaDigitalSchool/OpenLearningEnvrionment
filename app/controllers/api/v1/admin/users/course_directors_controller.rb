# frozen_string_literal: true
module Api
  module V1
    module Admin
      module Users
        # Api::V1::Admin::Users::CourseDirectorsController
        class CourseDirectorsController < ApplicationController
          before_action :authenticate_api_v1_user!
          load_and_authorize_resource
          before_action :load_permissions
          before_action :set_course_director, only: [:show, :update, :destroy]

          def index
            course_directors = CourseDirector.all
            render json: course_directors, status: :ok
          end

          def create
            course_director = CourseDirector.new(course_director_params)

            if course_director.save
              course_director.invite!(current_api_v1_user)
              render json: course_director, status: :created
            else
              render json: course_director.errors, status: :unprocessable_entity
            end
          end

          def show
            render json: @course_director, status: :ok
          end

          def update
            if @course_director.update(course_director_params)
              render json: @course_director, status: :ok
            else
              render json: @course_director.errors, status: :unprocessable_entity
            end
          end

          def destroy
            if @course_director.update(deleted: true)
              render json: nil, status: :no_content
            else
              render json: @course_director.errors, status: :unprocessable_entity
            end
          end

          private

          def course_director_params
            params.require(:course_director).permit(:title, :firstname, :lastname, :gender, :country, :birthdate,
                                                    :profession, :educational_attainment, :avatar, :interests,
                                                    :introduction, :email, :password, :password_confirmation)
          end

          def set_course_director
            @course_director = CourseDirector.find(params[:id])
          end
        end
      end
    end
  end
end
