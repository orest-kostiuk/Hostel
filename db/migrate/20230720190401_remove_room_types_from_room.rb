class RemoveRoomTypesFromRoom < ActiveRecord::Migration[5.2]
  def change
    remove_reference :rooms, :room_type, foreign_key: true
  end
end
