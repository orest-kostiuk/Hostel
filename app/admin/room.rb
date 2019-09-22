# frozen_string_literal: true

ActiveAdmin.register Room do
  permit_params :side

  menu label: I18n.t('active_admin.menu.items.room')

  scope :available do
    Room.where(room_status: 'available')
  end
  scope :busy do
    Room.where(room_status: 'busy')
  end

  index title: 'Кімнати' do
    selectable_column
    column :id
    column t('active_admin.rooms.room_type') do |room|
      room.room_type == 'small' ? '2 місний' : '3 місний'
    end
    column t('active_admin.rooms.block') do |r|
      r = r.block
      link_to [r.floor.side == 'left' ? 'Л' : 'П', r.number].join('-'), admin_block_path(r)
    end
    column t('active_admin.rooms.room_status'), :room_status
    column t('active_admin.rooms.room_places') do |room|
      places = room.room_places
      places - room.tenant_orders.where(order_status: 'ordered').map(&:count_places).sum
    end
    column t('active_admin.rooms.ordres') do |room|
      tenants = room.tenant_orders.where(order_status: 'ordered').map(&:tenant)
      array =  tenants.map { |t| "<br>#{link_to (t.full_name_present? ? [t.last_name, t.first_name, t.surname].join(' ') : t.to_s), admin_tenant_path(t)} місць(#{t.tenant_orders.last.count_places})" }
      array[0] = array[0].split('<br>').last if array[0]
      raw array.to_sentence
    end
    actions
  end

  show do
    attributes_table do
      row :tenants 
      row :room_type
      row :block do |room|
        if r = room.block
          link_to r.number, admin_block_path(r)
        end
      end
      row :floor
      row :room_status
      row :room_places
    end
  end

  filter :block, collection: lambda {
    Block.all.map { |b| ["#{b.floor.side == 'left' ? 'Л' : 'П'}-#{b.number}", b.id] }
  }

  action_item :view, only: :show do
    link_to t('active_admin.user.link.create_order'), new_admin_tenant_order_path(room_id: room.id), method: :get
  end
end
