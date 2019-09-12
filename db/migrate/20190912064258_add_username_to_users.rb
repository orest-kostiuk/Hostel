class AddUsernameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :login_code, :string
  end
end
