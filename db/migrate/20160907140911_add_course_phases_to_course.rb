class AddCoursePhasesToCourse < ActiveRecord::Migration[5.0]
  def change
    # add table course_phases
    create_table :course_phases do |t|
      t.references :course, index: true, foreign_key: true
      t.string     :title, :null => false, :default => ""
      t.datetime   :start_date
      t.datetime   :end_date
      t.boolean    :finished, default: false

      t.timestamps
    end

    # preferences transfer from course to course phase
    rename_table      :course_preferences, :course_phase_preferences
    remove_reference  :course_phase_preferences, :course
    add_reference     :course_phase_preferences, :course_phase, index: true, foreign_key: true

    # change reference for storages
    remove_reference  :storages, :course
    add_reference     :storages, :course_phase, index: true, foreign_key: true
  end
end
