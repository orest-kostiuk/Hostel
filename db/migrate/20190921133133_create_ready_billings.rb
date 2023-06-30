# frozen_string_literal: true

class CreateReadyBillings < ActiveRecord::Migration[5.2]
  def change
    create_table :ready_billings do |t|
      t.belongs_to :tenant
      t.belongs_to :balance
      t.belongs_to :billment
      t.integer :amount

      t.timestamps
    end
  end
end
