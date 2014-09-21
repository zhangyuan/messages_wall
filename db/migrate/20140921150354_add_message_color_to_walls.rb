class AddMessageColorToWalls < ActiveRecord::Migration
  def change
    add_column :walls, :message_color, :string, null: false, default: "black", limit: 20
  end
end
