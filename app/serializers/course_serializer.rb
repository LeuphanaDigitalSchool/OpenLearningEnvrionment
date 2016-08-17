# frozen_string_literal: true
# CourseSerializer
class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :start_date, :end_date, :storages, :preferences

  def start_date
    object.start_date.strftime('%Y-%m-%d') if object.start_date
  end

  def end_date
    object.end_date.strftime('%Y-%m-%d') if object.end_date
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

  def preferences
    object.course_preferences.collect do |p|
      {
        id: p.id,
        role: p.role.name,
        role_id: p.role_id,
        upload: p.upload_preferences,
        upload_pdf: p.upload_pdf,
        upload_jpg: p.upload_jpg,
        upload_mp3: p.upload_mp3,
        upload_mp4: p.upload_mp4,
        resource_description_add: p.resource_description_add,
        resource_description_del: p.resource_description_del,
        resources_del: p.resources_del,
        schedule_publishing: p.schedule_publishing,
        embed_external_links: p.embed_external_links
      }
    end
  end
end
