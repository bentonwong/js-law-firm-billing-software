class MatterNote < ApplicationRecord
  belongs_to :matter
  belongs_to :note
end
