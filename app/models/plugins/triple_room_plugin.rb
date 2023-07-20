module Plugins
  module TripleRoomPlugin

    PLACE_COUNT = 3

    def places
      PLACE_COUNT
    end

    def price
      200
    end

    def available
      self.tenants.count < PLACE_COUNT
    end
  end
end