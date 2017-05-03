class TimeEntry < ApplicationRecord

  belongs_to :matter
  belongs_to :lawyer

  def cost
    rate * duration
  end

  def self.accounts_receivable
    where("paid = ? AND billable = ?", false, false).sum {|time_entry| time_entry.cost}
  end

end
