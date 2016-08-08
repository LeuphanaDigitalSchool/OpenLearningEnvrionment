class ChangeAgeToBirthdateInUsers < ActiveRecord::Migration[5.0]
  def up
    remove_column :users, :age
    add_column :users, :birthdate, :date
  end

  def down
    add_column :users, :age, :integer
    remove_column :users, :birthdate
  end
end
