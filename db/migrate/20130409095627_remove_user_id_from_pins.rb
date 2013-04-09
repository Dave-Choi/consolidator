class RemoveUserIdFromPins < ActiveRecord::Migration
  def change
    remove_column :things, :user_id
  end
end
