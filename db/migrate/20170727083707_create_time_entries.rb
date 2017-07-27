class CreateTimeEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :time_entries do |t|
      t.date :date
      t.duration :decimal
      t.text :description
      t.boolean :billable
      t.boolean :paid
      t.integer :matter_id
      t.integer :lawyer_id
      t.datetime :created_at
      t.datetime :updated_at
      t.decimal :rate
    end
  end
end
