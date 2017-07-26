class AddRateToTimeEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :time_entries, :rate, :decimal
  end
end
