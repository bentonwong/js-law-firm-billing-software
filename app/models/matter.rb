class Matter < ApplicationRecord
  belongs_to :lawyer
  belongs_to :client
  has_many :time_entries
  validates :name, :lawyer_id, :client_id, presence: :true

  def calculate_matter_invoice
    time_entries.accounts_receivable
  end

  def unpaid_time_entries
    time_entries.where("paid = ?", false)
  end

end
