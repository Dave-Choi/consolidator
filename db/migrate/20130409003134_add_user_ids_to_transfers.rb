class AddUserIdsToTransfers < ActiveRecord::Migration
  def change
    add_column :transfers, :from_user_id, :integer
    add_index :transfers, :from_user_id
    add_column :transfers, :to_user_id, :integer
    add_index :transfers, :to_user_id
  end
end
