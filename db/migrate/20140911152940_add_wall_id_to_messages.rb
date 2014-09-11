class AddWallIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :wall_id, :integer, null: false, default: 0
  end
end
