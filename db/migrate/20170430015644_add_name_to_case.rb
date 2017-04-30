class AddNameToCase < ActiveRecord::Migration[5.0]
  def change
    add_column :cases, :name, :string
  end
end
