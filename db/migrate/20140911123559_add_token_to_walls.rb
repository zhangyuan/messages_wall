class AddTokenToWalls < ActiveRecord::Migration
  def change
    add_column :walls, :token, :string, null: false, default: '', limit: 40
  end
end
