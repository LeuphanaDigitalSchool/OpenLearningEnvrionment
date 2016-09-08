# frozen_string_literal: true
# StorageSerializer
class StorageSerializer < ActiveModel::Serializer
  attributes :id, :source, :name, :file, :description, :url, :course, :course_phase, :user, :deleted

  def user
    object.user.display_name
  end

  def course
    object.course_phase.course.title
  end

  def course_phase
    object.course_phase.title
  end
end
