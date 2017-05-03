class Client < ApplicationRecord
  has_many :matters
  has_many :lawyers, through: :matters

  def total_outstanding_balance
    self.matters.sum {|matter| matter.calculate_invoice}
  end

end
