module Plugins
  module DoubleRoomPlugin

    PLACE_COUNT = 2

    def places
      PLACE_COUNT
    end

    def calculate_price
      150
    end

    def check_availability
      self.tenants.count < PLACE_COUNT
    end
  end
end