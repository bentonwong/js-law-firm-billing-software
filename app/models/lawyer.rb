class Lawyer < ApplicationRecord

  has_many :matters
  has_many :clients, through: :matters
  has_many :time_entries
  #has_many :bar_memberships

  def self.current_rate(lawyer_id)
    find_by(id: lawyer_id).rate
  end

  #def bar_membership_attributes=(bm_attributes)
    #bm_attributes.each do |i, bm_attributes|
      #self.bar_memberships.build(bm_attributes) if bm_attributes.present? && bm_attributes[:state].present?
    #end
  #end


end
