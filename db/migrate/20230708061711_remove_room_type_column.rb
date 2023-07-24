class RemoveRoomTypeColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :rooms, :room_type
  end
end
