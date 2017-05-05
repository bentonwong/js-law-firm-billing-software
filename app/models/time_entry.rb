class TimeEntry < ApplicationRecord
  belongs_to :matter
  belongs_to :lawyer
  validates :date, :duration, :description, :matter_id, :lawyer_id, presence: :true
  validates :duration, numericality: { greater_than_or_equal_to: 0 }
  validates :description, length: { in: 2..500 }

  def cost
    rate * duration
  end

  def self.accounts_receivable
    where("paid = ? AND billable = ?", false, true).sum {|time_entry| time_entry.cost}
  end

  def self.outstanding_clients
    client_ids = Matter.all.map {|matter| matter.client_id if matter.time_entries.where("paid = ? AND billable = ?", false, true)}
    client_ids.uniq.map {|client_id| Client.find_by(id: client_id)}
  end

end
