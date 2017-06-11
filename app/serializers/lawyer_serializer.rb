class LawyerSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :matters
end
