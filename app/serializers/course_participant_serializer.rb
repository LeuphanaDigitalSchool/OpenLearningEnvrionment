# frozen_string_literal: true
# CourseParticipantSerializer
class CourseParticipantSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname, :role

  def role
    object.role.name
  end
end
