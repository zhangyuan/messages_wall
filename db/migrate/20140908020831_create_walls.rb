class CreateWalls < ActiveRecord::Migration
  def change
    create_table :walls do |t|
      t.string :title, null: false, default: "", limit: 30
      t.string :background_image, null: false, default: '', limit: 50
      t.string :qrcode, null: false, default: '', limit: 50
      t.string :logo, null: false, default: '', limit: 50

      t.timestamps
    end
  end
end
