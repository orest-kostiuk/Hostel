module Plugins
  module TripleRoomPlugin

    PLACE_COUNT = 3

    def places
      PLACE_COUNT
    end

    def calculate_price
      200
    end

    def check_availability
      self.tenants.count < PLACE_COUNT
    end
  end
end