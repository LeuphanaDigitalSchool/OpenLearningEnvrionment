# frozen_string_literal: true
module Api
  module V1
    # Api::V1::CoursesPhasesController
    class CoursePhasesController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_course_phase, only: [:show, :update]

      def index
        course = Course.find(params[:course_id])
        render json: course.course_phases, status: :ok
      end

      def show
        render json: @course_phase, status: :ok
      end

      def active
        active_phase = Course.find(params[:course_id]).course_phases.active
        render json: active_phase, serializer: CoursePhaseActiveSerializer, status: :ok
      end

      def preferences
        course_phase = CoursePhase.find(params[:course_phase_id])
        render json: course_phase, serializer: CoursePhasePreferenceSerializer, role: params[:role], status: :ok
      end

      def update
        if @course_phase.update(course_phase_params)
          render json: @course_phase, status: :ok
        else
          render json: @course_phase.errors, status: :unprocessable_entity
        end
      end

      private

      def course_phase_params
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

      def set_course_phase
        @course_phase = CoursePhase.find(params[:id])
      end
    end
  end
end
