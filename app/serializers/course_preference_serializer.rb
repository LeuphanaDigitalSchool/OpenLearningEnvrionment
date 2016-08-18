# frozen_string_literal: true
# CourseSerializer
class CoursePreferenceSerializer < ActiveModel::Serializer
  attributes :id, :preferences

  # rubocop:disable Metrics/AbcSize
  def preferences
    role_id = instance_options[:role] == 'teacher' ? 4 : 2
    preference = object.course_preferences.find_by(role_id: role_id)
    {
      role: preference.role.name,
      upload: preference.upload_preferences,
      upload_pdf: preference.upload_pdf,
      upload_jpg: preference.upload_jpg,
      upload_mp3: preference.upload_mp3,
      upload_mp4: preference.upload_mp4,
      resource_description_add: preference.resource_description_add,
      resource_description_del: preference.resource_description_del,
      resources_del: preference.resources_del,
      schedule_publishing: preference.schedule_publishing,
      embed_external_links: preference.embed_external_links
    }
  end
  # rubocop:enable Metrics/AbcSize
end
