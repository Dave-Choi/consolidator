class AddCreatedAtIndexToBorrowRequests < ActiveRecord::Migration
  def change
    add_index :borrow_requests, :created_at
  end
end
