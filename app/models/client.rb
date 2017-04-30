class Client < ApplicationRecord
  has_many :matters
  has_many :lawyers, through: :matters

end
