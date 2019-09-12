class Room < ApplicationRecord
  enum room_type: [:small, :big]
  enum room_status: [:available, :busy]
  before_create :set_count_places

  belongs_to :block
  has_many :tenant_orders
  has_many :tenants, through: :tenant_orders

  def set_count_places
    self.room_places = room_type == 'small' ? 2 : 3
  end
end
