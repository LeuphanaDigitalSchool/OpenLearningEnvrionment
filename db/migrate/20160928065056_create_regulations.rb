class CreateRegulations < ActiveRecord::Migration[5.0]
  def change
    create_table :regulations do |t|
      t.string :name
      t.string :file
    end
  end
end
