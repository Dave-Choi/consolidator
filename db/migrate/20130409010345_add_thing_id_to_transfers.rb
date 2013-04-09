class AddThingIdToTransfers < ActiveRecord::Migration
  def change
    add_column :transfers, :thing_id, :integer
    add_index :transfers, :thing_id
  end
end
