class AddDatetimeIndexToTransfers < ActiveRecord::Migration
  def change
    add_index :transfers, :datetime
  end
end
