# frozen_string_literal: true

class CreateMonths < ActiveRecord::Migration[5.2]
  def change
    create_table :months do |t|
      t.string :name
      t.timestamps
    end
    add_column :replenishments, :month_id, :integer
  end
end
