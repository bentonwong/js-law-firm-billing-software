class Matter < ApplicationRecord
  belongs_to :supervising_lawyer, :class_name => "Lawyer"
  belongs_to :client
  has_many :time_entries

  def calculate_matter_invoice
    billable_entries = time_entries.select {|time_entry| time_entry[:billable] && !time_entry[:paid]}
    billable_entries.sum {|time_entry| time_entry[:rate] * time_entry[:duration]}
  end

end
