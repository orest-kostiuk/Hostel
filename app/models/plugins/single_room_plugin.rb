module Plugins
  module SingleRoomPlugin
    PLACE_COUNT = 1

    def places
      PLACE_COUNT
    end

    def price
      100
    end

    def available
      self.tenants.count < PLACE_COUNT
    end
  end
end