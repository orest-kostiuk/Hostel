class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :telegram_id, :string
    add_column :users, :telegram_chat, :jsonb
  end
end
