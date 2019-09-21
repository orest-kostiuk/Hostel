# frozen_string_literal: true

ActiveAdmin.register Payment do
  permit_params :date_payed, :amount, :balance_id

  menu label: I18n.t('active_admin.menu.items.payment')

  index title: 'Витрати' do
  end
end
