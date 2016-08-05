# frozen_string_literal: true
module Api
  module V1
    module Admin
      # Api::V1::Admin::TeachersController
      class TeachersController < ApplicationController
        before_action :authenticate_api_v1_user!

        def index
          teachers = Teacher.all
          render json: teachers, status: :ok
        end

        def create
          teacher = Teacher.new(teacher_params)

          if teacher.save
            render json: teacher, status: :created
          else
            render json: teacher.errors, status: :unprocessable_entity
          end
        end

        private

        def teacher_params
          params.require(:teacher).permit(:title, :firstname, :lastname, :gender, :country, :age, :profession,
                                          :educational_attainment, :avatar, :interests, :introduction, :email,
                                          :password, :password_confirmation)
        end
      end
    end
  end
end
