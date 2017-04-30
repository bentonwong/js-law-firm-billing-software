class RenameColumnsInTimeEntries < ActiveRecord::Migration[5.0]
  def change
    rename_column :time_entries, :case_id, :matter_id
  end
end
