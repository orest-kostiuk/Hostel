# frozen_string_literal: true

ActiveAdmin.register Billment do
  actions :all, except: :new
  menu label: I18n.t('active_admin.menu.items.billment')

  member_action :generate_billing, method: :post do
  end

  index title: 'Рахунки' do
    column :id
    column :month
    column :ready_billings do |billment|
      billment.ready_billings.count
    end
    column :created_at
    actions
  end

  controller do
    def generate_billing
      month = Month.find(params[:id])
      GenerateBilling.new(month, current_admin_user).call
      redirect_to admin_month_path(month)
    end
  end

  show do
    panel "Виставлені рахунки" do
      table_for billment.ready_billings do
        column :id
        column :tenant do |r_b|
          if b = r_b.tenant
            link_to (b.full_name_present? ? [b.last_name, b.first_name,
                                                b.surname].join(' ') : b.to_s), admin_tenant_path(b)
          end
        end
        column :room do |billment|
          if room = billment.tenant.tenant_orders&.where(order_status: 'ordered')&.first&.room
            link_to "#{room.block.number} #{room.room_type == 'small' ? '2м' : '3м'}", admin_room_path(room)
          end
        end
        column :balance
        column :amount
        column :created_at
        column :visit do |r_b|
          link_to 'Переглянути', admin_ready_billing_path(r_b)
        end
      end
    end
  end
end
