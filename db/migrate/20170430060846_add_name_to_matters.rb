class AddNameToMatters < ActiveRecord::Migration[5.0]
  def change
    add_column :matters, :name, :string
  end
end
