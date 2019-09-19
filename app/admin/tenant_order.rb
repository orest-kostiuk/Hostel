ActiveAdmin.register TenantOrder do
  permit_params :room_id, :tenant_id, :start_date, :end_date, :count_places
  menu label: "Список оренд"

  filter :block, collection: -> {
    Block.all.map { |b| ["#{b.floor.side == 'left' ? "Л" : 'П'}-#{b.number}", b.id] }
  }

  scope :ordered do
    TenantOrder.where(order_status: 'ordered')
  end


  scope :complited do
    TenantOrder.where(order_status: 'complited')
  end


  index do
    selectable_column
    column :id
    column :room do |o|
      room = o.room
      link_to "#{room.block.number} #{room.room_type == 'small' ? '2м' : '3м'}", admin_room_path(room)
    end
    column :tenant do |o|
      t = o.tenant
      link_to [t.last_name, t.first_name, t.surname].join(' '), admin_tenant_path(t)
    end
    column :start_date
    column :end_date
    column :order_status
    actions
  end

  form do |f|
    f.inputs do
      f.input :room, collection: Room.all.map { |r| [[r.block.floor.side == 'right' ? 'П' : "Л", r.block.number, r.room_type == 'small' ? '2м' : '3м'].join('-'), r.id] }
      f.input :tenant, collection: Tenant.all.map { |t| [[t.last_name, t.first_name, t.surname, t.the_taxpayer_identification_number].join(' '), t.id] }
      f.input :start_date
      f.input :end_date
      f.input :count_places
    end
    f.actions
  end

  controller do
    def new
      @tenant = Tenant.find_by_id(params['tenant_id'])
      @room = Room.find_by_id(params['room_id'])
      @tenant_order = TenantOrder.new(tenant: @tenant, room: @room)
    end
  end
end
