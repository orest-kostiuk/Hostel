class AddTypeToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :type, :string
  end
end
