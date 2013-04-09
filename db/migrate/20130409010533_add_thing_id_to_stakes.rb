class AddThingIdToStakes < ActiveRecord::Migration
  def change
    add_column :stakes, :thing_id, :integer
    add_index :stakes, :thing_id
  end
end
