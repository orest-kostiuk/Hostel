class CreateReplenishments < ActiveRecord::Migration[5.2]
  def change
    create_table :replenishments do |t|
      t.belongs_to :balance
      t.integer :amount
      t.date :replenishment_date

      t.timestamps
    end
  end
end
