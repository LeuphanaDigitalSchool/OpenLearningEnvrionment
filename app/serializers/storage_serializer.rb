# frozen_string_literal: true
# StorageSerializer
class StorageSerializer < ActiveModel::Serializer
  attributes :id, :source, :name, :file, :description, :url, :course_phases, :user, :deleted

  def user
    object.user.display_name
  end

  def course_phases
    object.course_phases.collect do |phase|
      {
        id: phase.id,
        course: phase.course.title,
        phase: phase.title
      }
    end
  end
end
