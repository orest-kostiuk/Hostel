# frozen_string_literal: true

ActiveAdmin.register Billment do
  actions :all, except: :new
  menu label: I18n.t('active_admin.menu.items.billment')

  member_action :generate_billing, method: :post do
  end

  index title: 'Рахунки' do
  end

  controller do
    def generate_billing
      month = Month.find(params[:id])
      GenerateBilling.new(month, current_admin_user).call
      redirect_to admin_month_path(month)
    end
  end
end
