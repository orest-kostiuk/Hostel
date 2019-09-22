# frozen_string_literal: true

ActiveAdmin.register Payment do
  permit_params :date_payed, :amount, :balance_id

  menu label: I18n.t('active_admin.menu.items.payment')

  index title: 'Витрати' do
    column :tenant do |p|
      if tenant = p.balance.tenant
        link_to (tenant.full_name_present? ? [tenant.last_name, tenant.first_name,
                                              tenant.surname].join(' ') : tenant.to_s), admin_tenant_path(tenant)
      end
    end
    column :amount
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :tenant do |b|
        if tenant = b.balance.tenant
          link_to (tenant.full_name_present? ? [tenant.last_name, tenant.first_name,
                                                tenant.surname].join(' ') : tenant.to_s), admin_tenant_path(tenant)
        end
      end
      row :amount
      row :created_at
    end
  end
end
