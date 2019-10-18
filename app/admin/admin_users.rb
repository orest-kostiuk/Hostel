# frozen_string_literal: true

ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  menu label: I18n.t('active_admin.menu.items.admin_user')

  index title: 'АдмінКористувачі' do
    selectable_column
    id_column
    column t('active_admin.user.column.email'), :email
    column t('active_admin.user.column.current_sign_in_at'), :current_sign_in_at
    column t('active_admin.user.column.sign_in_count'), :sign_in_count
    column t('active_admin.user.column.created_at'), :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email, label: 'Емейл'
      f.input :password, label: 'Пароль'
      f.input :password_confirmation, label: 'Повторити пароль'
    end
    f.actions
  end

  member_action :generate_billing, method: :post do
  end


  controller do
    def generate_billing
      date = Date.today.at_beginning_of_month
      month = Month.find(date.month)
      count = GenerateBilling.new(month, current_admin_user).call
      flash[:success] = "Успішно виставлені рахунки #{count}"
      redirect_to admin_billment_path(current_admin_user.billments.last)
    end
  end

  action_item :view, only: :show do
    link_to "Виставити рахунки",
            generate_billing_admin_admin_user_path, method: :post
  end



end
