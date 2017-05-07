class MatterTag < ApplicationRecord
  belongs_to :matter
  belongs_to :tag
end
