class RenameCasesToMatters < ActiveRecord::Migration[5.0]
  def change
    rename_table :cases, :matters
  end
end
