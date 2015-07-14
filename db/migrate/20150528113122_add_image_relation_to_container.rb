class AddImageRelationToContainer < ActiveRecord::Migration
  def up
    add_column :containers, :container_image_id, :bigint
  end

  def down
    remove_column :containers, :container_image_id
  end
end
