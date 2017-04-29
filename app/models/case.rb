class Case < ApplicationRecord
  belongs_to :lawyer
  belongs_to :client
  has_many :time_entries

end
