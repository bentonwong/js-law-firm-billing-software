class DropMattersColumnFromTimeEntries < ActiveRecord::Migration[5.0]
  def change
    remove_column :matters, :name
  end
end
