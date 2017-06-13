class LawyerSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :matters
  has_many :clients, through: :matters
  has_many :time_entries, through: :matters
end
