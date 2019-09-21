# frozen_string_literal: true

ActiveAdmin.register Tenant do
  permit_params :first_name, :surname, :last_name, :index, :region, :district, :city, :street, :house_number,
                :passport_series, :who_issued_the_passport, :when_issued_the_passport, :the_taxpayer_identification_number,
                :phone_number, :login_code, :user_id

  menu label: I18n.t('active_admin.menu.items.tenant')

  index title: 'Орендарі' do
    selectable_column
    column :id
    column t('active_admin.user.column.room') do |t|
      if room = t.tenant_orders&.where(order_status: 'ordered')&.first&.room
        link_to "#{room.block.number} #{room.room_type == 'small' ? '2м' : '3м'}", admin_room_path(room)
      end
    end
    column t('active_admin.tenants.tenant') do |t|
      [t.last_name, t.first_name, t.surname].join(' ')
    end
    column t('active_admin.tenants.user') do |t|
      if user = t.user
        link_to (user.full_name_present? ? [user.last_name, user.first_name,
                                            user.surname].join(' ') : user.email), admin_user_path(user)
      end
    end
    column t('active_admin.tenants.balance') do |t|
      if balance = t.balance
        link_to balance.account_balance, admin_balance_path(balance)
      end
    end
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
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
    end
    f.actions
  end

  show do
    attributes_table do
      row :user do |tenant|
        if u = tenant.user
          link_to [u.first_name, u.surname, u.last_name].join(' '), admin_user_path(u)
        end
      end
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

  member_action :create_balance, method: :post do
  end

  controller do
    def create_balance
      t = Tenant.find(params[:id])
      t.balance_create
      redirect_to admin_tenant_path t
      flash[:notice] = 'Успішно створенно'
    end
  end

  action_item :view, only: :show, if: proc { tenant.balance.nil? } do
    link_to t('active_admin.tenants.link.create_balance'), create_balance_admin_tenant_path(tenant.id), method: :post
  end
  action_item :view, only: :show do
    link_to t('active_admin.user.link.create_order'), new_admin_tenant_order_path(tenant_id: tenant.id), method: :get
  end
end
