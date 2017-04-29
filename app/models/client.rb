class Client < ApplicationRecord
  has_many :cases
  has_many :lawyers, through: :cases
  
end
