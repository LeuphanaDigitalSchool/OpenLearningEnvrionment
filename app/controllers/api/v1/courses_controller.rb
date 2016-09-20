# frozen_string_literal: true
module Api
  module V1
    # Api::V1::CoursesController
    class CoursesController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_course, only: [:show, :participants, :update, :destroy]

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

      def participants
        participants = User.participants
        render json: participants, each_serializer: CourseParticipantSerializer, status: :ok
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
        params.require(:course).permit(:title, :description, :start_date, :end_date, course_phases_attributes: [
                                         :id, :title, :start_date, :end_date, :finished,
                                         course_phase_preferences_attributes: [:id, :role_id, :upload_pdf, :upload_jpg,
                                                                               :upload_mp3, :upload_mp4,
                                                                               :resource_description_add,
                                                                               :resource_description_del,
                                                                               :resources_del,
                                                                               :schedule_publishing,
                                                                               :embed_external_links]
                                       ])
      end

      def set_course
        @course = Course.find(params[:id])
      end
    end
  end
end
