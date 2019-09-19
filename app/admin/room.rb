ActiveAdmin.register Room do
  permit_params :side
  menu label: "Кімнати"


  scope :available do
    Room.where(room_status: 'available')
  end
  scope :busy do
    Room.where(room_status: 'busy')
  end

  index do
    selectable_column
    column :id
    column :room_type do |room|
      room.room_type == 'small' ? '2 місний' : '3 місний'
    end
    column :block do |r|
      r = r.block
      link_to [r.floor.side == 'left' ? "Л" : 'П', r.number ].join('-'), admin_block_path(r)
    end
    column :room_status
    column :room_places do |room|
      places = room.room_places
      places - room.tenant_orders.where(order_status: 'ordered').map { |o| o.count_places}.sum
    end
    column :ordres do |room|
      tenants = room.tenant_orders.where(order_status: 'ordered').map { |o| o.tenant}
      array =  tenants.map { |t| "<br>#{link_to [t.last_name, t.first_name, t.surname].join(' '), admin_tenant_path(t)} місць(#{t.tenant_orders.last.count_places})" }
      array[0] = array[0].split('<br>').last if array[0]
      raw array.to_sentence
    end
    actions
  end

  show do
    attributes_table do
      row :tenants
      row :room_type
      row :block
      row :room_status
      row :room_places
    end
    active_admin_comments
  end

  filter :block, collection: -> {
    Block.all.map { |b| ["#{b.floor.side == 'left' ? "Л" : 'П'}-#{b.number}", b.id] }
  }

  action_item :view, only: :show do
    link_to 'Create order', new_admin_tenant_order_path(room_id: room.id), method: :get
  end
end
