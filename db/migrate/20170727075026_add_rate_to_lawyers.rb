class AddRateToLawyers < ActiveRecord::Migration[5.0]
  def change
    add_column :lawyers, :rate, :decimal
  end
end
