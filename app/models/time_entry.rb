class TimeEntry < ApplicationRecord

  belongs_to :matter
  belongs_to :lawyer

  def self.calculate_invoice
    self.time_entries.collect do |time_entry|
      time_entry[:rate] * time_entry[:duration] if time_entry[:billable]
    end.sum
  end

end
