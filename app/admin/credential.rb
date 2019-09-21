# frozen_string_literal: true

ActiveAdmin.register Credential do
  permit_params :name, :int_value, :str_value, :admin_user_id

  menu label: I18n.t('active_admin.menu.items.credential')

  index title: 'Дані' do
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :int_value
      f.input :str_value
    end
    f.actions
  end
end
