class AddPlacesToTenantOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :tenant_orders, :count_places, :integer, default: 1
  end
end
