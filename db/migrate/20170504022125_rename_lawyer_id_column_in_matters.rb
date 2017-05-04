class RenameLawyerIdColumnInMatters < ActiveRecord::Migration[5.0]
  def change
    rename_column :matters, :lawyer_id, :supervising_lawyer_id
  end
end
