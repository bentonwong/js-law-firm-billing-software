class MatterExpense < ApplicationRecord
  belongs_to :matter
  belongs_to :expense
  
end
