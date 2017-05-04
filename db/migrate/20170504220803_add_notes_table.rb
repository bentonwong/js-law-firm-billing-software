class AddNotesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.date :date
      t.text :content
    end
  end
end
