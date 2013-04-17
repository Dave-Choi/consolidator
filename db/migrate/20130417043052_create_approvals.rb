class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.references :borrow_request
      t.references :user
      t.string :status, :default => "pending"

      t.timestamps
    end
    add_index :approvals, :borrow_request_id
    add_index :approvals, :user_id
    add_index :approvals, :status
  end
end
