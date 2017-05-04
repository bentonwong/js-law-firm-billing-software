class CreateMatterExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :matter_expenses do |t|

      t.timestamps
    end
  end
end
