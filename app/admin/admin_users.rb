# frozen_string_literal: true

ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  menu label: I18n.t('active_admin.menu.items.admin_user')

  index title: 'АдмінКористувачі' do
    selectable_column
    id_column
    column t('active_admin.user.column.email'), :email
    column t('active_admin.user.column.current_sign_in_at')
    column t('active_admin.user.column.sign_in_count')
    column t('active_admin.user.column.created_at')
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
