# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :first_name

  menu label: I18n.t('active_admin.menu.items.user')

  index title: 'Користувачі' do
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

  member_action :generate_information, method: :post do
  end

  controller do
    def generate_information
      u = User.find(params[:id])
      tenant = GenerateInformation.new(u).process
      redirect_to edit_admin_tenant_path(tenant)
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :first_name
      f.input :surname
      f.input :last_name
      f.input :index
      f.input :region
      f.input :district
      f.input :city
      f.input :street
      f.input :house_number
      f.input :passport_series
      f.input :who_issued_the_passport
      f.input :when_issued_the_passport
      f.input :the_taxpayer_identification_number
      f.input :phone_number
      f.input :login_code
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :first_name
      row :surname
      row :last_name
      row :index
      row :region
      row :district
      row :city
      row :street
      row :house_number
      row :passport_series
      row :who_issued_the_passport
      row :when_issued_the_passport
      row :the_taxpayer_identification_number
      row :phone_number
      row :login_code
    end
  end

  action_item :view, only: :show, if: proc { !user.tenant } do
    link_to t('active_admin.user.link.generate_information'), generate_information_admin_user_path(user.id), method: :post
  end
end
