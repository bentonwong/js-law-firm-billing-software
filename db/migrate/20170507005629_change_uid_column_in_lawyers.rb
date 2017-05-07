class ChangeUidColumnInLawyers < ActiveRecord::Migration[5.0]
  def change
    change_column :lawyers, :uid, :integer, :limit => 8
  end
end
