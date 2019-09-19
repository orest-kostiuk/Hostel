ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column t('admin.users.column.email')
    column t('admin.users.column.current_sign_in_at')
    column t('admin.users.column.sign_in_count')
    column t('admin.users.column.created_at')
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
