class RenameSupervisingLawyerIdToLawyerIdInMatters < ActiveRecord::Migration[5.0]
  def change
    rename_column :matters, :supervising_lawyer_id, :lawyer_id
  end
end
