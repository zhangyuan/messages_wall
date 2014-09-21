class AddMessageBackgroundColorToWalls < ActiveRecord::Migration
  def change
    add_column :walls, :message_background_color, :string, null: false, default: '', limit: 20
  end
end
