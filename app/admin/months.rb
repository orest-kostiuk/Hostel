# frozen_string_literal: true

ActiveAdmin.register Month do
  menu label: I18n.t('active_admin.menu.items.month')

  actions :all, except: %i[new edit]
  action_item :view, only: :show do
    link_to t('active_admin.user.link.generate_information'), generate_billing_admin_billment_path(month.id), method: :post
  end

 index title: 'Місяці' do
   selectable_column
   column :id
   column t('active_admin.user.column.name'), :name
   column t('active_admin.months.created_at'), :created_at
   column t('active_admin.months.updated_at'), :updated_at
   actions
 end
end
