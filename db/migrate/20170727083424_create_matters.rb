class CreateMatters < ActiveRecord::Migration[5.0]
  def change
    create_table :matters do |t|
      t.integer :lawyer_id
      t.integer :client_id
      t.string :name
    end
  end
end
