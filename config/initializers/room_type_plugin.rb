require 'half_lux'

module RoomTypes
  AVAILABLE_ROOMS = [SingleRoom, DoubleRoom, TripleRoom]
end
RoomTypes::AVAILABLE_ROOMS << RoomTypes::HalfLux
