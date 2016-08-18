# frozen_string_literal: true
# StorageSerializer
class StorageSerializer < ActiveModel::Serializer
  attributes :id, :source, :name, :file, :description, :url, :course, :user, :deleted

  def user
    object.user.display_name
  end

  def course
    object.course.title
  end
end
