class AddNameToTimeEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :time_entries, :name, :string
  end
end
