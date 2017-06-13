class TimeEntrySerializer < ActiveModel::Serializer
  attributes :id, :date, :description, :duration, :matter_id, :rate
  belongs_to :lawyer
end
