class TimeEntry < ApplicationRecord
  belongs_to :case
  belongs_to :lawyer

  end
end
