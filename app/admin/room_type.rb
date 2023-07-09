# frozen_string_literal: true

ActiveAdmin.register RoomType do
  permit_params :name, :plugin
  # actions :all, except: :new
  # menu label: I18n.t('active_admin.menu.items.balance')
  #
  # index title: 'Баланси' do
  #   column t('active_admin.tenants.tenant') do |b|
  #     if tenant = b.tenant
  #       link_to (tenant.full_name_present? ? [tenant.last_name, tenant.first_name,
  #                                             tenant.surname].join(' ') : tenant.to_s), admin_tenant_path(tenant)
  #     end
  #   end
  #   column t('active_admin.balance.account_balance'), :account_balance
  #   column t('active_admin.tenants.user'), :user do |b|
  #     if user = b.tenant&.user
  #       link_to (user.full_name_present? ? [user.last_name, user.first_name,
  #                                           user.surname].join(' ') : user.to_s), admin_tenant_path(user)
  #     end
  #   end
  #   column t('active_admin.balance.ordered_room'), :ordered_room do |b|
  #     if room = b.tenant&.tenant_orders&.first&.room
  #       link_to room.block.number, admin_room_path(room)
  #     end
  #   end
  #   actions
  # end
  #
  # show do
  #   attributes_table do
  #     row :tenant do |b|
  #       if tenant = b.tenant
  #         link_to (tenant.full_name_present? ? [tenant.last_name, tenant.first_name,
  #                                               tenant.surname].join(' ') : tenant.to_s), admin_tenant_path(tenant)
  #       end
  #     end
  #     row :account_balance
  #     row :created_at
  #     row :updated_at
  #   end
  # end
  #
  # form do |f|
  #   f.inputs do
  #     f.input :tenant, label: 'Орендар'
  #     f.input :account_balance, label: 'Баланс'
  #   end
  #   f.actions
  # end

end
