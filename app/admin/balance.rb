# frozen_string_literal: true

ActiveAdmin.register Balance do
  actions :all, except: :new
  menu label: I18n.t('active_admin.menu.items.balance')

  index title: 'Баланси' do
    column :tenant do |b|
      if tenant = b.tenant
        link_to (tenant.full_name_present? ? [tenant.last_name, tenant.first_name,
                                              tenant.surname].join(' ') : tenant.to_s), admin_tenant_path(tenant)
      end
    end
    column :account_balance
    column :user do |b|
      if user = b.tenant&.user
        link_to (user.full_name_present? ? [user.last_name, user.first_name,
                                            user.surname].join(' ') : user.to_s), admin_tenant_path(user)
      end
    end
    column :ordered_room do |b|
      if room = b.tenant&.tenant_orders.ordered&.first&.room
        link_to room.block.number, admin_room_path(room)
      end
    end
    actions
  end
end
