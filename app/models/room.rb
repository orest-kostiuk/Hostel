# frozen_string_literal: true

class Room < ApplicationRecord
  after_initialize :include_plugin_module
  belongs_to :block
  has_many :tenant_orders, class_name: 'TenantOrder'
  has_many :tenants, class_name: "Tenant", through: :tenant_orders

  def to_s
    "#{available ? 'Вільна' : 'Зайнята'} #{places}"
  end

  private

  def include_plugin_module
    unless room_type.blank?
      module_name = "RoomTypes::#{room_type}"
      if RoomTypes::AVAILABLE_ROOMS.map(&:to_s).include?(module_name)
        self.extend(module_name.constantize)
      else
        raise "Room type #{room_type} is not supported"
      end
    end
  end
end
