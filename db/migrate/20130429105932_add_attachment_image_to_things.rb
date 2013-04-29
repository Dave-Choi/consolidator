class AddAttachmentImageToThings < ActiveRecord::Migration
  def self.up
    change_table :things do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :things, :image
  end
end
