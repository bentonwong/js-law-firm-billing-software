class DropTagsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :tags
    drop_table :matter_tags
  end
end
