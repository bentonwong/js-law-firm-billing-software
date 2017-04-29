class CreateTimeEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :time_entries do |t|
      t.string :matter
      t.date :date
      t.decimal :duration
      t.text :description
      t.boolean :billable
      t.boolean :paid
      t.integer :case_id
      t.integer :lawyer_id

      t.timestamps
    end
  end
end
