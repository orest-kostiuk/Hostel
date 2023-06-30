class AddIsPaidToReadyBillings < ActiveRecord::Migration[5.2]
  def change
    add_column :ready_billings, :is_paid, :boolean, default: false
  end
end
