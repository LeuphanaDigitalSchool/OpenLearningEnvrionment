class RenameColumnTypeInStorages < ActiveRecord::Migration[5.0]
  def change
    rename_column :storages, :type, :source
  end
end
