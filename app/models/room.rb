# frozen_string_literal: true

class Room < ApplicationRecord
  # enum room_type: %i[small big]
  # enum room_status: %i[available busy]
  before_create :set_count_places
  after_initialize :include_plugin_module


  belongs_to :room_type

  belongs_to :block
  has_many :tenant_orders, class_name: 'TenantOrder'
  has_many :tenants, class_name: "Tenant", through: :tenant_orders


  def set_count_places
    self.room_places = room_type == 'small' ? 2 : 3
  end

  def to_s
    "#{check_availability ? 'Вільна' : 'Зайнята'} #{places}"
  end

  private

  def include_plugin_module
    if room_type && room_type.plugin.present?
      self.class.include(PLUGINS[room_type.plugin])
    end
  end
end
