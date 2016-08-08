# frozen_string_literal: true
module Api
  module V1
    module Admin
      module Users
        # Api::V1::Admin::Users::TeachersController
        class TeachersController < ApplicationController
          before_action :authenticate_api_v1_user!
          before_action :set_teacher, only: [:show]

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

          def show
            render json: @teacher, status: :ok
          end

          private

          def teacher_params
            params.require(:teacher).permit(:title, :firstname, :lastname, :gender, :country, :birthdate, :profession,
                                            :educational_attainment, :avatar, :interests, :introduction, :email,
                                            :password, :password_confirmation)
          end

          def set_teacher
            @teacher = Teacher.find(params[:id])
          end
        end
      end
    end
  end
end
