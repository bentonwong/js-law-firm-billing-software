class AddMatterExpensesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :matter_expenses do |t|
      t.integer :expense_id
      t.integer :matter_id
    end
  end
end
