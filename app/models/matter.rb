class Matter < ApplicationRecord
  belongs_to :lawyer
  belongs_to :client
  has_many :time_entries
  has_many :matter_tags
  has_many :tags, through: :matter_tags
  accepts_nested_attributes_for :tags, reject_if: lambda {|attributes| attributes['name'].blank?}

  def calculate_matter_invoice
    billable_entries = time_entries.select {|time_entry| time_entry[:billable] && !time_entry[:paid]}
    billable_entries.sum {|time_entry| time_entry[:rate] * time_entry[:duration]}
  end

  def tags_attributes=(tags_attributes)
    tags_attributes.each do |i, tag_attributes| #parses out the hashes if tags_attributes is either an array or a hash
      self.tags.build(tag_attributes) if tag_attributes.present? && tag_attributes[:name].present? #checks for nil
    end
  end

end
