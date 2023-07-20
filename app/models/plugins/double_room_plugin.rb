module Plugins
  module DoubleRoomPlugin

    PLACE_COUNT = 2

    def places
      PLACE_COUNT
    end

    def price
      150
    end

    def available
      self.tenants.count < PLACE_COUNT
    end
  end
end