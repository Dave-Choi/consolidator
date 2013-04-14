class AddHeldByToThings < ActiveRecord::Migration
  def change
    add_column :things, :held_by, :integer
  end
end
