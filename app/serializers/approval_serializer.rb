class ApprovalSerializer < ActiveModel::Serializer
  embed :ids
  has_one :borrow_request, :user
  attributes :status
end
