# frozen_string_literal: true
# CourseSerializer
class CourseSerializer < ActiveModel::Serializer
  attributes :title, :description, :start_date, :end_date, :storages

  def start_date
    object.start_date.strftime('%Y-%m-%d')
  end

  def end_date
    object.end_date.strftime('%Y-%m-%d')
  end

  def storages
    object.storages.collect do |storage|
      {
        id: storage.id,
        source: storage.source,
        file: storage.file,
        description: storage.description,
        url: storage.url,
        user: storage.user.display_name
      }
    end
  end
end
