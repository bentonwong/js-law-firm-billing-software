class Lawyer < ApplicationRecord

  has_many :matters
  has_many :clients, through: :matters
  has_many :time_entries

  def self.current_rate(lawyer_id)
    Lawyer.find_by(id: lawyer_id).rate
  end

end
