class ThingSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :name, :image
  has_one :holder
  has_many :users, :key => :owner_ids
  has_many :stakes, :borrow_requests
end
