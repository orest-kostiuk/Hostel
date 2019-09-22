# frozen_string_literal: true

class TenantOrder < ApplicationRecord
  belongs_to :room
  belongs_to :tenant

  before_create :complited_last
  before_create :set_start_date
  after_create :set_room_status
  enum order_status: %i[ordered complited]

  def complited_last
    order = tenant&.tenant_orders&.where(order_status: 'ordered').first
    if order
      order.complited!
      order.set_room_status
    end
  end

  def set_room_status
    places = room.room_places
    available_places = places - room.tenant_orders.where(order_status: 'ordered').map(&:count_places).sum
    if available_places <= 0
      room.busy!
    else
      room.available!
    end
  end

  def set_start_date
    self.start_date = Time.now if start_date.blank?
  end

  def complited!
    update_attributes(order_status: 'complited', end_date: Time.now)
  end
end
