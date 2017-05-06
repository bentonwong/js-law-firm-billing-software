class AddColumnsToLawyersTable < ActiveRecord::Migration[5.0]
  def change
    add_column :lawyers, :provider, :string
    add_column :lawyers, :oauth_token, :string
    add_column :lawyers, :oauth_expires_at, :datetime
  end
end
