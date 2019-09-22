# frozen_string_literal: true

ActiveAdmin.register Replenishment do
  menu label: I18n.t('active_admin.menu.items.replenishment')
  permit_params :replenishment_date, :amount, :balance_id, :month_id, :billment_id

  index title: 'Надходження' do
    column :month
    column :billment
    column :amount
    column :balance
    column :replenishment_date
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :amount
      f.input :balance
      f.input :replenishment_date
      f.input :month
      f.input :billment
      f.actions
    end
  end
end
