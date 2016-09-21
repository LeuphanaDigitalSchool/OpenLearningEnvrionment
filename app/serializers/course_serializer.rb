# frozen_string_literal: true
# CourseSerializer
class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :start_date, :end_date, :title_in_side_nav, :description_in_your_courses,
             :title_in_your_courses
  has_many :course_phases, serializer: CoursePhaseSerializer

  def start_date
    object.start_date.strftime('%Y-%m-%d') if object.start_date
  end

  def end_date
    object.end_date.strftime('%Y-%m-%d') if object.end_date
  end

  def title_in_side_nav
    if object.title.size > 19
      object.title[0, 18] + '...'
    else
      object.title
    end
  end

  def title_in_your_courses
    if object.title.size > 26
      object.title[0, 25] + '...'
    else
      object.title
    end
  end

  def description_in_your_courses
    if object.description.size > 64
      object.description[0, 65] + '...'
    else
      object.description
    end
  end
end
