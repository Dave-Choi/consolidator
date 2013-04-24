class AddBorrowRequestIdToTransfers < ActiveRecord::Migration
  def change
    add_column :transfers, :borrow_request_id, :integer
    add_index :transfers, :borrow_request_id
  end
end
