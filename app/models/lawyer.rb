class Lawyer < ApplicationRecord

  has_many :matters
  has_many :clients, through: :matters
  has_many :time_entries

end
