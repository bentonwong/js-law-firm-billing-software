class Client < ApplicationRecord
  has_many :matters
  has_many :lawyers, through: :matters
  validates :name, :address, :phone, :email, presence: :true
  validates :email, uniqueness: :true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  def total_outstanding_balance
    matters.sum {|matter| matter.calculate_matter_invoice}
  end

  def self.outstanding_clients
    select {|client| client.total_outstanding_balance > 0}
  end

  def outstanding_matters
    matters.select {|matter| matter.time_entries.accounts_receivable > 0}
  end

end
