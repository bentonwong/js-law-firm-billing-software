class CreateLawyers < ActiveRecord::Migration[5.0]
  def change
    create_table :lawyers do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :rate
    end
  end
end
