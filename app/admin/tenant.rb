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
        link_to balance.to_s, admin_balance_path(balance)
      end
    end
    actions
  end

  filter :id, label: "Повне ім\'я", as: :select, collection: -> {
    Tenant.all.map { |t| [t.full_name, t.id] }
  }

  form do |f|
    f.inputs do
      f.input :first_name, label: "Ім'я"
      f.input :surname, label: 'По батькові'
      f.input :last_name, label: 'Прізвище'
      f.input :index, label: 'Індекс'
      f.input :region, label: 'Регіон'
      f.input :district, label: 'Область'
      f.input :city, label: 'Містро'
      f.input :street, label: 'Вулиця'
      f.input :house_number, label: 'Номер будинку'
      f.input :passport_series, label: 'Серія паспорту'
      f.input :who_issued_the_passport, label: 'Хто видав паспорт'
      f.input :when_issued_the_passport, label: 'Коли видано паспорт'
      f.input :the_taxpayer_identification_number, label: 'Номер платника податків'
      f.input :phone_number, label: 'Номер телефону'
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

    panel "Payments" do
      table_for tenant.balance.payments do
        column :amount
        column :created_at
        column :visit do |p|
          link_to 'Переглянути', admin_payment_path(p)
        end
      end
    end

    panel "Replenishment" do
      table_for tenant.balance.replenishments do
        column :amount
        column :created_at
        column :visit do |r|
          link_to 'Переглянути', admin_replenishment_path(r)
        end
      end
    end

    panel "ReadyBilling" do
      table_for tenant.ready_billing do
        column :month do |r_b|
          r_b.billment.month.name
        end
        column :amount
        column :created_at
        column :visit do |r_b|
          link_to 'Переглянути', admin_ready_billing_path(r_b)
        end
      end
    end

    panel "Balance" do
      table_for tenant.balance do
        column :account_balance
        column :created_at
        column :visit do |balance|
          link_to 'Переглянути', admin_balance_path(balance)
        end
      end
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
