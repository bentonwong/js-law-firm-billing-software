module MatterHelper
  def matter_lawyer_exists?
    !@lawyer.nil?
  end

  def matter_notes_not_blank
    !@matter.notes.blank?
  end

  def matters_not_blank_for_this(instance)
    !instance.matters.blank?
  end

  def sum_of_unpaid_time_entries_for(matter)
    matter.unpaid_time_entries.sum {|time_entry| time_entry.cost }
  end

end
