class AddTitleColorToWalls < ActiveRecord::Migration
  def change
    add_column :walls, :title_color, :string, null: false, default: '', limit: 20
  end
end
