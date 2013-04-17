class CreateBorrowRequests < ActiveRecord::Migration
  def change
    create_table :borrow_requests do |t|
      t.references :thing
      t.references :user

      t.timestamps
    end
    add_index :borrow_requests, :thing_id
    add_index :borrow_requests, :user_id
  end
end
