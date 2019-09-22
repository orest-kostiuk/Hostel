# frozen_string_literal: true

class Room < ApplicationRecord
  enum room_type: %i[small big]
  enum room_status: %i[available busy]
  before_create :set_count_places

  belongs_to :block
  has_many :tenant_orders
  has_many :tenants, through: :tenant_orders

  def set_count_places
    self.room_places = room_type == 'small' ? 2 : 3
  end

  def to_s
    "#{available? ? 'Вільна' : 'Зайнята'} #{small? ? '2м' : '3м'}"
  end
end
