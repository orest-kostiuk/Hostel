# frozen_string_literal: true

ActiveAdmin.register ReadyBilling do
  permit_params :balance_id, :amount, :billment_id, :tenant_id
  menu label: I18n.t('active_admin.menu.items.ready_billing')

  index title: 'Виконані рахунки' do
    selectable_column
    column :id
    column :tenant do |readybilling|
      if u = readybilling.tenant
        link_to (u.full_name_present? ? [u.last_name, u.first_name,
                                           u.surname].join(' ') : u.to_s), admin_tenant_path(u)
      end
    end
    column :balance
    column :billment
    column :amount
    column :created_at
    column :updated_at
    actions
  end
end
