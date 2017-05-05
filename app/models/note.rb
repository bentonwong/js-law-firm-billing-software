class Note < ApplicationRecord
  has_many :matter_notes
  has_many :matters, through: :matter_notes

  validates :date, :content, presence: :true

end
