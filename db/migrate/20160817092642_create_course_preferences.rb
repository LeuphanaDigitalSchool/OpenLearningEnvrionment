class CreateCoursePreferences < ActiveRecord::Migration[5.0]
  def change
    create_table :course_preferences do |t|
      t.references :course, foreign_key: true
      t.references :role, foreign_key: true
      t.boolean :upload_pdf, default: false
      t.boolean :upload_jpg, default: false
      t.boolean :upload_mp3, default: false
      t.boolean :upload_mp4, default: false
      t.boolean :resource_description_add, default: false
      t.boolean :resource_description_del, default: false
      t.boolean :resources_del, default: false
      t.boolean :schedule_publishing, default: false
      t.boolean :embed_external_links, default: false

      t.timestamps
    end
  end
end
