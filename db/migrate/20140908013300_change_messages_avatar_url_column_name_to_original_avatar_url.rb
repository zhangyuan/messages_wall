class ChangeMessagesAvatarUrlColumnNameToOriginalAvatarUrl < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.rename :avatar_url, :original_avatar_url
    end
  end
end
