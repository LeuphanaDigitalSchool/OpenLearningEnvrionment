# frozen_string_literal: true
# CourseSerializer
class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :start_date, :end_date, :short_title
  has_many :course_phases, serializer: CoursePhaseSerializer

  def start_date
    object.start_date.strftime('%Y-%m-%d') if object.start_date
  end

  def end_date
    object.end_date.strftime('%Y-%m-%d') if object.end_date
  end

  def short_title
    if object.title.size > 21
      object.title[0,20] + "..." 
    else
      object.title
    end
  end
end
