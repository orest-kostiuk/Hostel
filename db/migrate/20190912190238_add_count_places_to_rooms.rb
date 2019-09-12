class AddCountPlacesToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :room_places, :integer
  end
end
