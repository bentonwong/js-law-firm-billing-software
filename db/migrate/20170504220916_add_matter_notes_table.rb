class AddMatterNotesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :matter_notes do |t|
      t.integer :matter_id
      t.integer :note_id
    end
  end
end
