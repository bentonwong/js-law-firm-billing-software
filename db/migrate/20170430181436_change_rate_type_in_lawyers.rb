class ChangeRateTypeInLawyers < ActiveRecord::Migration[5.0]
  def change
    change_column :lawyers, :rate, :decimal
  end
end
