class Matter < ApplicationRecord
  belongs_to :lawyer
  belongs_to :client
  has_many :time_entries
  has_many :matter_expenses
  has_many :expenses, through: :matter_expenses

  def calculate_matter_invoice
    billable_entries = time_entries.select {|time_entry| time_entry[:billable] && !time_entry[:paid]}
    billable_entries.sum {|time_entry| time_entry[:rate] * time_entry[:duration]}
  end

end
