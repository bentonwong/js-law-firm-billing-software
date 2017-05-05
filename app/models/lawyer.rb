class Lawyer < ApplicationRecord
  has_many :matters
  has_many :clients, through: :matters
  has_many :time_entries
  validates :name, :email, :rate, presence: :true
  validates :email, uniqueness: :true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates :rate, numericality: { greater_than_or_equal_to: 0 }

  validates :password, length: { minimum: 8 }, allow_nil: true
  has_secure_password

  def self.current_rate(lawyer_id)
    find_by(id: lawyer_id).rate
  end

end
