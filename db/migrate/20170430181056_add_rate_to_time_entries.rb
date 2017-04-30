class AddRateToTimeEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :time_entries, :rate, :decimal, :precision => 8, :scale => 2
  end
end
