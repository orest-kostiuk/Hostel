ActiveAdmin.register Room do
  permit_params :side

  scope :available do
    Room.where(room_status: t('admin.room.available'))
  end
  scope :busy do
    Room.where(room_status: t('admin.room.busy'))
  end

  index do
    selectable_column
    column :id
    column t('admin.rooms.room_type') do |room|
      room.room_type == 'small' ? '2 місний' : '3 місний'
    end
    column :block do |r|
      r = r.block
      link_to [r.floor.side == 'left' ? "Л" : 'П', r.number ].join('-'), admin_block_path(r)
    end
    column t('admin.rooms.room_status')
    column t('admin.rooms.room_places') do |room|
      places = room.room_places
      places - room.tenant_orders.where(order_status: 'ordered').map { |o| o.count_places}.sum
    end
    column :ordered do |room|
      tenants = room.tenant_orders.where(order_status: 'ordered').map { |o| o.tenant}
      array =  tenants.map { |t| "<br>#{link_to [t.last_name, t.first_name, t.surname].join(' '), admin_tenant_path(t)} місць(#{t.tenant_orders.last.count_places})" }
      array[0] = array[0].split('<br>').last if array[0]
      raw array.to_sentence
    end
    actions
  end

  filter :block, collection: -> {
    Block.all.map { |b| ["#{b.floor.side == 'left' ? "Л" : 'П'}-#{b.number}", b.id] }
  }

  action_item :view, only: :show do
    link_to t('admin.create_order'), new_admin_tenant_order_path(room_id: room.id), method: :get
  end
end
