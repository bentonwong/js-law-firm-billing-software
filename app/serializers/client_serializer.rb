class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :phone, :email
  has_many :matters
end
