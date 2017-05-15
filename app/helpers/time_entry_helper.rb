module TimeEntryHelper
  def display_billable_cost_of(time_entry)
    time_entry.billable? ? number_to_currency(time_entry.cost) : "(no charge)"
  end

  def billable_status_of(time_entry)
    time_entry.billable? ? "Yes" : "No"
  end

  def paid_status_of(time_entry)
    time_entry.paid? ? "Yes" : "No"
  end

end
