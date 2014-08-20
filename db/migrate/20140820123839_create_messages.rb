class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :message_id, null: false, default: 0
      t.text :content
      t.string :remark_name, null: false, default: '', limit: 20
      t.text :avatar_url

      t.timestamps
    end
  end
end
