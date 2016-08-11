# frozen_string_literal: true
module Api
  module V1
    module Admin
      module Users
        # Api::V1::Admin::Users::StudentsController
        class StudentsController < ApplicationController
          before_action :authenticate_api_v1_user!
          before_action :set_student, only: [:show, :update, :destroy]

          def index
            students = Student.all
            render json: students, status: :ok
          end

          def create
            student = Student.new(student_params)

            if student.save
              student.invite!(current_api_v1_user)
              render json: student, status: :created
            else
              render json: student.errors, status: :unprocessable_entity
            end
          end

          def show
            render json: @student, status: :ok
          end

          def update
            if @student.update(student_params)
              render json: @student, status: :ok
            else
              render json: @student.errors, status: :unprocessable_entity
            end
          end

          def destroy
            if @student.update(deleted: true)
              render json: nil, status: :no_content
            else
              render json: @student.errors, status: :unprocessable_entity
            end
          end

          private

          def student_params
            params.require(:student).permit(:title, :firstname, :lastname, :gender, :country, :birthdate, :profession,
                                            :educational_attainment, :avatar, :interests, :introduction, :email,
                                            :password, :password_confirmation, :data_privacy, :terms_and_conditions,
                                            :honor_code)
          end

          def set_student
            @student = Student.find(params[:id])
          end
        end
      end
    end
  end
end
