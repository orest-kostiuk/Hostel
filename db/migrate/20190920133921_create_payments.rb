# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.belongs_to :balance
      t.integer :amount
      t.date :date_payed
      t.timestamps
    end
  end
end
