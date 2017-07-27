class ChangeRateInLawyers < ActiveRecord::Migration[5.0]
  def change
    change_column :lawyers, :rate, :decimal, :precision => 9, :scale => 2
  end
end
