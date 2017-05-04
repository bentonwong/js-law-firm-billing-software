class ChangeColumnNameInMatterTags < ActiveRecord::Migration[5.0]
  def change
    rename_column :matter_tags, :expense_id, :tag_id
  end
end
