class AddUidColumnToLawyersTable < ActiveRecord::Migration[5.0]
  def change
    add_column :lawyers, :uid, :integer
  end
end
