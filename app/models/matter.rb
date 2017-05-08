class Matter < ApplicationRecord
  belongs_to :lawyer
  belongs_to :client
  has_many :time_entries
  has_many :matter_notes
  has_many :notes, through: :matter_notes
  validates :name, :lawyer_id, :client_id, presence: :true

  def calculate_matter_invoice
    billable_entries = time_entries.select {|time_entry| time_entry[:billable] && !time_entry[:paid]}
    billable_entries.sum {|time_entry| time_entry[:rate] * time_entry[:duration]}
  end

  def notes_attributes=(notes_attributes)
    notes_attributes.values.each {|note_attributes| self.notes.build(note_attributes) if note_attributes.present? && note_attributes[:content].present?}
  end

end
