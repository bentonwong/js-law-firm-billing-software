class Tag < ApplicationRecord
  has_many :matter_tags
  has_many :matters, through: :matter_tags

end
