class CreateLawyers < ActiveRecord::Migration[5.0]
  def change
    create_table :lawyers do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :provider
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.string :uid
      t.decimal :rate, :default => 0
    end
  end
end
