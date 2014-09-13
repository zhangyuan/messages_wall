class AddPublishingStatusIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :publishing_status_id, :integer, null: false, default: 0, limit: 1
  end
end
