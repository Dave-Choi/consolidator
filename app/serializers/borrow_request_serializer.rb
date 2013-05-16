class BorrowRequestSerializer < ActiveModel::Serializer
  embed :ids
  has_one :thing, :user, :transfer
  has_many :approvals, :key => :approval_ids
end
