# frozen_string_literal: true

ActiveAdmin.register Billment do
  actions :all, except: :new
  menu label: I18n.t('active_admin.menu.items.billment')

  member_action :generate_billing, method: :post do
  end

  index title: 'Рахунки' do
    column :id
    column :month
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
    panel "Post Details" do
      table_for billment.ready_billings do
        column :id
        column :tenant do |billment|
          if b = billment.tenant
            link_to (b.full_name_present? ? [b.last_name, b.first_name,
                                                b.surname].join(' ') : b.to_s), admin_tenant_path(b)
          end
        end
        column :balance
        column :amount
        column :created_at
      end
    end
  end
end
