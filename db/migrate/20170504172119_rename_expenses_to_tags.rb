class RenameExpensesToTags < ActiveRecord::Migration[5.0]
  def change
    rename_table :expenses, :tags
  end
end
