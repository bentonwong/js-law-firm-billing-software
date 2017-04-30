class TimeEntry < ApplicationRecord

  belongs_to :matter
  belongs_to :lawyer

  end
end
