class DropRoomTypeTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :room_types
  end
end
