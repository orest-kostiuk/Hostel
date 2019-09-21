ActiveAdmin.register Replenishment do
  menu label: I18n.t('active_admin.menu.items.replenishment')
  permit_params :replenishment_date, :amount, :balance_id

  index :title => 'Надходження' do
  end
  form do |f|
    f.inputs do
      f.input :amount
      f.input :balance
      f.input :replenishment_date
    f.actions
    end
  end
end
