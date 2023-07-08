module Plugins
  module SingleRoomPlugin
    PLACE_COUNT = 1

    def places
      PLACE_COUNT
    end

    def calculate_price
      100
    end

    def check_availability
      self.tenants < PLACE_COUNT
    end
  end

end