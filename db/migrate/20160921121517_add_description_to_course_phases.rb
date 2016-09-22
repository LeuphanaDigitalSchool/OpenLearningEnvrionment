class AddDescriptionToCoursePhases < ActiveRecord::Migration[5.0]
  def change
    add_column :course_phases, :description, :text
  end
end
