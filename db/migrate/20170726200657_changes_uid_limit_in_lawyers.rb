class ChangesUidLimitInLawyers < ActiveRecord::Migration[5.0]
  def change
    change_column :lawyers, :uid, :integer, :limit => 16
  end
end
