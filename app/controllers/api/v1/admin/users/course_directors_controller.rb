# frozen_string_literal: true
module Api
  module V1
    module Admin
      module Users
        # Api::V1::Admin::Users::CourseDirectorsController
        class CourseDirectorsController < ApplicationController
          before_action :authenticate_api_v1_user!

          def index
            course_directors = CourseDirector.all
            render json: course_directors, status: :ok
          end

          def create
            course_director = CourseDirector.new(scourse_director_params)

            if course_director.save
              render json: course_director, status: :created
            else
              render json: course_director.errors, status: :unprocessable_entity
            end
          end

          private

          def scourse_director_params
            params.require(:course_director).permit(:title, :firstname, :lastname, :gender, :country, :birthdate,
                                                    :profession, :educational_attainment, :avatar, :interests,
                                                    :introduction, :email, :password, :password_confirmation)
          end
        end
      end
    end
  end
end
