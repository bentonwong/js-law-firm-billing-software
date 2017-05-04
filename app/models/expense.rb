class Expense < ApplicationRecord
  has_one :matter_expenses
  has_one :matter, through: :matter_expenses

end
