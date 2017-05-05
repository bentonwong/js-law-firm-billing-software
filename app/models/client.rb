class Client < ApplicationRecord
  has_many :matters
  has_many :lawyers, through: :matters
  validates :name, :address, :phone, :email, presence: :true

  def total_outstanding_balance
    matters.sum {|matter| matter.calculate_matter_invoice}
  end

end
