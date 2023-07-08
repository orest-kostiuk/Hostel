class RoomType < ApplicationRecord
  has_many :rooms, class_name: 'Room', foreign_key: 'room_type_id'
end
