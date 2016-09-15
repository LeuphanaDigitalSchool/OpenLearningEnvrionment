# frozen_string_literal: true
# CoursePhaseSerializer
class CoursePhaseActiveSerializer < ActiveModel::Serializer
  attributes :id, :title, :start_date, :end_date, :active, :storages, :course_phase_preferences_attributes

  def start_date
    object.start_date.to_date if object.start_date
  end

  def end_date
    object.end_date.to_date if object.end_date
  end

  def active
    DateTime.now.to_date >= object.start_date.to_date && object.end_date.to_date >= DateTime.now.to_date
  end

  def storages
    object.storages.collect do |storage|
      {
        id: storage.id,
        source: storage.source,
        file: storage.file.url,
        description: storage.description,
        url: storage.url,
        user: storage.user.display_name
      }
    end
  end

  # rubocop:disable Metrics/AbcSize
  def course_phase_preferences_attributes
    object.course_phase_preferences.collect do |p|
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
  # rubocop:enable Metrics/AbcSize
end
