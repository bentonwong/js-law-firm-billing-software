class AddExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.date :date
      t.text :description
      t.decimal :amount
    end
  end
end
