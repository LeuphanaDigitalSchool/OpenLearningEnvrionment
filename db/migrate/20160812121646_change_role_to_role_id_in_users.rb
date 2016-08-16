class ChangeRoleToRoleIdInUsers < ActiveRecord::Migration[5.0]
  def up
    rename_column :users, :role, :role_id
  end

  def down
    rename_column :users, :role_id, :role
  end
end
