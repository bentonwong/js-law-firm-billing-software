class Matter < ApplicationRecord
  belongs_to :lawyer
  belongs_to :client
  has_many :time_entries

  def calculate_invoice
    billable_entries = self.time_entries.select {|time_entry| time_entry[:billable] && !time_entry[:paid]}
    billable_entries.collect {|time_entry| time_entry[:rate] * time_entry[:duration]}.sum
  end

end
