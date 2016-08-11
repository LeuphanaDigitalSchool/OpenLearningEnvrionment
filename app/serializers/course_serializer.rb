# frozen_string_literal: true
# CourseSerializer
class CourseSerializer < ActiveModel::Serializer
  attributes :title, :description, :start_date, :end_date
end
