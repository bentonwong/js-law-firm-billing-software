class DropBarMembershipsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :bar_memberships
  end
end
