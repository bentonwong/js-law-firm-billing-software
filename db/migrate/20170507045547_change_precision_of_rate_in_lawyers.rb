class ChangePrecisionOfRateInLawyers < ActiveRecord::Migration[5.0]
  def change
    def change
      change_column :lawyers, :rate, :decimal, precision: 8, scale: 2, default: 0.00
    end
  end
end
