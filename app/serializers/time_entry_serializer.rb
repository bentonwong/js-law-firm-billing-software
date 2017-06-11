class TimeEntrySerializer < ActiveModel::Serializer
  attributes :id, :date, :description, :duration, :matter_id
  belongs_to :lawyer
end
