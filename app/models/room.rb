# frozen_string_literal: true

class Room < ApplicationRecord
  after_initialize :include_plugin_module
  belongs_to :block
  has_many :tenant_orders, class_name: 'TenantOrder'
  has_many :tenants, class_name: "Tenant", through: :tenant_orders

  def to_s
    "#{available ? 'Вільна' : 'Зайнята'} #{PLACE_COUNT}"
  end

  private

  def include_plugin_module
    unless room_type.blank?
      self.class.include(PLUGINS[room_type])
    end
  end
end
