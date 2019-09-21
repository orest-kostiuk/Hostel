# frozen_string_literal: true

class AddUserIdToTenants < ActiveRecord::Migration[5.2]
  def change
    add_column :tenants, :user_id, :integer
  end
end
