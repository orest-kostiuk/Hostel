class RemoveColumnsFromRooms < ActiveRecord::Migration[5.2]
  def change
    remove_columns :rooms, :room_status, :room_places, :type
  end
end
