class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :email, null: false, default: '', limit: 40
      t.string :password_digest, null: false, default: '', limit: 80

      t.timestamps
    end
  end
end
