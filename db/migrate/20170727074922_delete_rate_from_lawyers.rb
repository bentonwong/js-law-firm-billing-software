class DeleteRateFromLawyers < ActiveRecord::Migration[5.0]
  def change
    remove_column :lawyers, :rate
  end
end
