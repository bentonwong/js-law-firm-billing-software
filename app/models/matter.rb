class Matter < ApplicationRecord
  belongs_to :lawyer
  belongs_to :client
  has_many :time_entries

  def calculate_invoice
    self.time_entries.collect do |time_entry|
      time_entry[:rate] * time_entry[:duration] if time_entry[:billable]
    end.sum
  end

end
