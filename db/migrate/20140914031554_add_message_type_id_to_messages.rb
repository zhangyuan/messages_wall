class AddMessageTypeIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :message_type_id, :integer, null: false, default: 0, limit: 1
  end
end
