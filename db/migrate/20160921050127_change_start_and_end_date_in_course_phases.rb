class ChangeStartAndEndDateInCoursePhases < ActiveRecord::Migration[5.0]
  def up
    change_column :course_phases, :start_date, :datetime
    change_column :course_phases, :end_date, :datetime
  end
  
  def down
    change_column :course_phases, :start_date, :date
    change_column :course_phases, :end_date, :date
  end
end
