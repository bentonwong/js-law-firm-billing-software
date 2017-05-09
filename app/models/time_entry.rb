class TimeEntry < ApplicationRecord
  belongs_to :matter
  belongs_to :lawyer
  validates :date, :duration, :description, :matter_id, :lawyer_id, presence: :true
  validates :duration, :rate, numericality: { greater_than_or_equal_to: 0 }
  validates :description, length: { in: 2..100 }
  validate :valid_date?

  def valid_date?
    errors.add(:date, "cannot be in the future") if date > Date.today
  end

  def cost
    rate * duration
  end

  def self.accounts_receivable
    where("paid = ? AND billable = ?", false, true).sum {|time_entry| time_entry.cost}
  end

end
