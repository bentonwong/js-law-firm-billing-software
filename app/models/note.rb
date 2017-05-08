class Note < ApplicationRecord
  has_one :matter_note
  has_one :matter, through: :matter_notes
end
