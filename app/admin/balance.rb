ActiveAdmin.register Balance do
  permit_params :side

  menu label: I18n.t('active_admin.menu.items.balance')

  index :title => 'Баланс' do
  end
end
