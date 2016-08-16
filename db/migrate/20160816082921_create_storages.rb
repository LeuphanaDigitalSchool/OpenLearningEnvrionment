class CreateStorages < ActiveRecord::Migration[5.0]
  def change
    create_table :storages do |t|
      t.string     :type, null: false, default: ''
      t.string     :name
      t.string     :file
      t.text       :description
      t.text       :url
      t.references :course, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean    :deleted, default: false

      t.timestamps
    end
  end
end
