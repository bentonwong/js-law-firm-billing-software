class Matter < ApplicationRecord
  belongs_to :lawyer
  belongs_to :client
  has_many :time_entries
  has_many :matter_tags
  has_many :tags, through: :matter_tags
  has_many :matter_notes
  has_many :notes, through: :matter_notes

  def calculate_matter_invoice
    billable_entries = time_entries.select {|time_entry| time_entry[:billable] && !time_entry[:paid]}
    billable_entries.sum {|time_entry| time_entry[:rate] * time_entry[:duration]}
  end

  def tags_attributes=(tags_attributes)
    tags_attributes.values.each {|tags_attribute| self.tags.build(tags_attribute) if tags_attribute.present? && tags_attribute[:name].present?}
  end

  def notes_attributes=(notes_attributes)
    notes_attributes.values.each {|note_attributes| self.notes.build(note_attributes) if note_attributes.present? && note_attributes[:content].present?}
  end

end
