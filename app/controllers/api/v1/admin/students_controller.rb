# frozen_string_literal: true
module Api
  module V1
    module Admin
      # Api::V1::Admin::StudentsController
      class StudentsController < ApplicationController
        before_action :authenticate_api_v1_user!

        def index
          students = Student.all
          render json: students, status: :ok
        end

        def create
          student = Student.new(student_params)

          if student.save
            render json: student, status: :created
          else
            render json: student.errors, status: :unprocessable_entity
          end
        end

        private

        def student_params
          params.require(:student).permit(:title, :firstname, :lastname, :gender, :country, :birthdate, :profession,
                                          :educational_attainment, :avatar, :interests, :introduction, :email,
                                          :password, :password_confirmation, :data_privacy, :terms_and_conditions,
                                          :honor_code)
        end
      end
    end
  end
end
