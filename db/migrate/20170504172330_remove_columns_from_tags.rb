class RemoveColumnsFromTags < ActiveRecord::Migration[5.0]
  def change
    remove_column :tags, :date
    remove_column :tags, :amount
    remove_column :tags, :description
    add_column :tags, :name, :string
  end
end
