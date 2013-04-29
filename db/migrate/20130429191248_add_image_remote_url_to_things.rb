class AddImageRemoteUrlToThings < ActiveRecord::Migration
  def change
    add_column :things, :image_remote_url, :string
  end
end
