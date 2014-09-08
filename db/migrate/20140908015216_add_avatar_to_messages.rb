class AddAvatarToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :avatar, :string, null: false, default: '', limit: 50
  end
end
