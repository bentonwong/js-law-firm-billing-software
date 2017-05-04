class ChangeTableNameMatterExpensesToMatterTags < ActiveRecord::Migration[5.0]
  def change
    rename_table :matter_expenses, :matter_tags
  end
end
