class Matter < ApplicationRecord
  belongs_to :lawyer
  belongs_to :client
  has_many :time_entries
  has_many :matter_notes
  has_many :notes, through: :matter_notes
  validates :name, :lawyer_id, :client_id, presence: :true

  def calculate_matter_invoice
    time_entries.accounts_receivable
  end

  def notes_attributes=(notes_attributes)
    notes_attributes.values.each {|note_attributes| self.notes.build(note_attributes) if note_attributes.present? && note_attributes[:content].present?}
  end

end
