class TimeEntry < ApplicationRecord

  belongs_to :matter
  belongs_to :lawyer

  def self.calculate_invoice

  end

end
