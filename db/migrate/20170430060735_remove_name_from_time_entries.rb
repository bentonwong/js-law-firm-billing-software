class RemoveNameFromTimeEntries < ActiveRecord::Migration[5.0]
  def change
    remove_column :time_entries, :name
  end
end
