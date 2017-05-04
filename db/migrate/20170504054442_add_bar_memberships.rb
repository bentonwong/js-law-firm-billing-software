class AddBarMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :bar_memberships do |t|
      t.string :name
      t.string :state
      t.integer :lawyer_id
    end
  end
end
