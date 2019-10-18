# frozen_string_literal: true

ActiveAdmin.register Credential do
  permit_params :name, :int_value, :str_value, :admin_user_id

  menu label: I18n.t('active_admin.menu.items.credential')

  index title: 'Дані' do
    column :id
    column :name
    column :int_value
    column :str_value
    actions
  end

  form do |f|
    f.inputs do
      f.input :name, label: "Ім'я"
      f.input :int_value, label: 'Значення цифрою'
      f.input :str_value, label: 'Значення буквами'
    end
    f.actions
  end
end
