class AddDurationToWalls < ActiveRecord::Migration
  def change
    add_column :walls, :duration, :integer, null: false, default: 0
  end
end
