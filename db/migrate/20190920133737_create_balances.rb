# frozen_string_literal: true

class CreateBalances < ActiveRecord::Migration[5.2]
  def change
    create_table :balances do |t|
      t.belongs_to :tenant
      t.float :account_balance, default: 0.0
      t.timestamps
    end
  end
end
