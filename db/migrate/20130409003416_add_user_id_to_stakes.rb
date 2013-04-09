class AddUserIdToStakes < ActiveRecord::Migration
  def change
    add_column :stakes, :user_id, :integer
    add_index :stakes, :user_id
  end
end
