class CreateCases < ActiveRecord::Migration[5.0]
  def change
    create_table :cases do |t|
      t.integer :lawyer_id
      t.integer :client_id
    end
  end
end
