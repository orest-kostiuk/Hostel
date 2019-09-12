class TenantOrder < ApplicationRecord
  belongs_to :room
  belongs_to :tenant

  before_create :complited_last
  after_create :set_room_status
  enum order_status: [:ordered, :complited]

  def complited_last
    order = tenant&.tenant_orders&.where(order_status: 'ordered').first
    order.update_attribute(:order_status, 'complited') if order
  end

  def set_room_status
    places = room.room_places
    available_places = places - room.tenant_orders.where(order_status: 'ordered').map { |o| o.count_places}.sum
    if available_places <= 0
      room.busy!
    end
  end
end
