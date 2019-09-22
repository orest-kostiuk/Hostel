# frozen_string_literal: true

ActiveAdmin.register TenantOrder do
  permit_params :room_id, :tenant_id, :start_date, :end_date, :count_places

  menu label: I18n.t('active_admin.menu.items.tenant_order')

  filter :block, collection: lambda {
    Block.all.map { |b| ["#{b.floor.side == 'left' ? 'Л' : 'П'}-#{b.number}", b.id] }
  }

  scope I18n.t('active_admin.tenant_order.all'), :all do
    TenantOrder.all
  end

  scope  I18n.t('active_admin.tenant_order.ordered') do
    TenantOrder.where(order_status: 'ordered')
  end

  scope I18n.t('active_admin.tenant_order.complited') do
    TenantOrder.where(order_status: 'complited')
  end

  index title: 'Список оренд' do
    selectable_column
    column :id
    column t('active_admin.user.column.room') do |o|
      room = o.room
      link_to "#{room.block.number} #{room.room_type == 'small' ? '2м' : '3м'}", admin_room_path(room)
    end
    column t('active_admin.tenants.tenant') do |b|
      if tenant = b.tenant
      link_to (tenant.full_name_present? ? [tenant.last_name, tenant.first_name,
                                            tenant.surname].join(' ') : tenant.to_s), admin_tenant_path(tenant)
      end
    end
    column t('active_admin.tenant_order.start_date'), :start_date
    column t('active_admin.tenant_order.end_date'), :end_date
    column t('active_admin.tenant_order.order_status'), :order_status
    actions
  end

  form do |f|
    f.inputs do
      f.input :room, collection: Room.all.map { |r| [[r.block.floor.side == 'right' ? 'П' : 'Л', r.block.number, r.room_type == 'small' ? '2м' : '3м'].join('-'), r.id] unless r.busy? }
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

  show do
    attributes_table do
      row :room do |tenant_order|
        if r = tenant_order.room
          link_to r.to_s, admin_room_path(r)
        end
      end
      row :tenant do |tenant_order|
        if t = tenant_order.tenant
          link_to [t.first_name, t.surname, t.last_name].join(' '), admin_tenant_path(t)
        end
      end
      row :start_date
      row :end_date
      row :order_status
      row :created_at
      row :updated_at
      row :count_places
    end
  end
end
