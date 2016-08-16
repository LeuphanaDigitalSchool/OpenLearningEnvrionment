# frozen_string_literal: true
# StorageSerializer
class StorageSerializer < ActiveModel::Serializer
  attributes :type, :name, :file, :description, :url, :course, :user, :deleted

  def user
    object.user.collect do |u|
      {
        id: u.id,
        user: "#{u.try(:lastname)} #{u.try(:firstname)}",
        email: u.email
      }
    end
  end

  def course
    object.course.collect do |c|
      {
        id: c.id,
        title: c.title
      }
    end
  end
end