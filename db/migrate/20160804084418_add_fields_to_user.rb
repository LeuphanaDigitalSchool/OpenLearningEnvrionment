class AddFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :title, :string
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :gender, :integer
    add_column :users, :country, :string
    add_column :users, :age, :integer
    add_column :users, :educational_attainment, :integer
    add_column :users, :profession, :string
    add_column :users, :avatar, :string
    add_column :users, :interests, :text
    add_column :users, :timezone, :string
    add_column :users, :introduction, :text
    add_column :users, :data_privacy, :boolean, default: false
    add_column :users, :terms_and_conditions, :boolean, default: false
    add_column :users, :honor_code, :boolean, default: false
    add_column :users, :role, :integer, default: 0
  end
end
