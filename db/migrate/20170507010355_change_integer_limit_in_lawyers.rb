class ChangeIntegerLimitInLawyers < ActiveRecord::Migration[5.0]
  def change
    change_column :lawyers, :uid, :integer
  end
end
