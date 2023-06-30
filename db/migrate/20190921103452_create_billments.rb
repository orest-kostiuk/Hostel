# frozen_string_literal: true

class CreateBillments < ActiveRecord::Migration[5.2]
  def change
    create_table :billments do |t|
      t.date :date_done
      t.belongs_to :month
      t.belongs_to :admin_user

      t.timestamps
    end
    add_column :replenishments, :billment_id, :integer
  end
end
