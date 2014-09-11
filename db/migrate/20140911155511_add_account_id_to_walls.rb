class AddAccountIdToWalls < ActiveRecord::Migration
  def change
    add_column :walls, :account_id, :integer, null: false, default: 0
  end
end
