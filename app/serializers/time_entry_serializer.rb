class TimeEntrySerializer < ActiveModel::Serializer
  attributes :id, :date, :description, :duration, :matter_id, :lawyer_id
end
