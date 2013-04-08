class CreateStakes < ActiveRecord::Migration
  def change
    create_table :stakes do |t|
      t.decimal :amount

      t.timestamps
    end
  end
end
