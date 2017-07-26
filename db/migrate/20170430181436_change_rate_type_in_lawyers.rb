class ChangeRateTypeInLawyers < ActiveRecord::Migration[5.0]
  def change
    change_column :lawyers, :rate, 'numeric USING CAST(rate AS numeric)'
  end
end
