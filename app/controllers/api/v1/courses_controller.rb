# frozen_string_literal: true
module Api
  module V1
    # Api::V1::CoursesController
    class CoursesController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_course, only: [:show, :update, :destroy]

      def index
        courses = Course.all
        render json: courses, status: :ok
      end

      def create
        course = Course.new(course_params)

        if course.save
          render json: course, status: :created
        else
          render json: course.errors, status: :unprocessable_entity
        end
      end

      def show
        render json: @course, status: :ok
      end

      def update
        if @course.update(course_params)
          render json: @course, status: :ok
        else
          render json: @course.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @course.update(deleted: true)
          render json: nil, status: :no_content
        else
          render json: @course.errors, status: :unprocessable_entity
        end
      end

      private

      def course_params
        params.require(:course).permit(:title, :description, :start_date, :end_date)
      end

      def set_course
        @course = Course.find(params[:id])
      end
    end
  end
end