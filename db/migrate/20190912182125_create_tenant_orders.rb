# frozen_string_literal: true

class CreateTenantOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :tenant_orders do |t|
      t.belongs_to :room
      t.belongs_to :tenant
      t.date :start_date
      t.date :end_date
      t.integer :order_status, default: 0

      t.timestamps
    end
  end
end
