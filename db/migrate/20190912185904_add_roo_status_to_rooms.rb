class AddRooStatusToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :room_status, :integer, default: 0
  end
end
