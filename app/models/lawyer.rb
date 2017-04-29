class Lawyer < ApplicationRecord
  has_secure_password

  has_many :cases
  has_many :clients, through: :cases
  has_many :time_entries

end
