class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.string :name
      t.string :action
      t.string :subject_class
      t.string :subject_id

      t.timestamps
    end
  end
end
