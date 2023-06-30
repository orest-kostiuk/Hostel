# frozen_string_literal: true

ActiveAdmin.register Replenishment do
  menu label: I18n.t('active_admin.menu.items.replenishment')
  permit_params :replenishment_date, :amount, :balance_id

  index title: 'Надходження' do
    column :amount
    column :balance
    column :replenishment_date
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :amount, label: 'Сума'
      f.input :balance, label: 'Баланс'
      f.input :replenishment_date, label: 'День поповнення'
      f.actions
    end
  end

  show do
    attributes_table do
      row :amount
      row :balance
      row :replenishment_date
      row :created_at
      row :updated_at
    end
  end
end
