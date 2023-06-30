# frozen_string_literal: true

class GenerateBilling
  def initialize(month, admin)
    @month = month
    return unless @month
    date = Date.today.at_beginning_of_month
    @billment = Billment.take_object(date)
    @billment ||= admin.billments.create(month: month, date_done: date)
    @count = 0
  end

  def call
    get_all_active_orders_tenants
    process_billing
    @count
  end

  private

  def get_all_active_orders_tenants
    @active_order_tenants = TenantOrder.ordered.map(&:tenant)
  end

  def process_billing
    per_month = Credential.billing_per_month.last.int_value
    per_day = (per_month / Time.days_in_month(Date.today.prev_month.month, Date.today.year).to_f).round(3)
    @active_order_tenants.each do |tenant|
      if tenant.ready_billing.any?
        create_ready_billing(tenant, per_month) unless tenant.ready_billing.last&.created_at.at_beginning_of_month == Date.today.at_beginning_of_month
      else
        t_o = tenant.tenant_orders.ordered.first
        create_ready_billing(tenant, ((Date.today - t_o.start_date).to_i * per_day))
      end
    end
  end

  def create_ready_billing(tenant, amount)
    @count += 1
    @billment.ready_billings.create(tenant: tenant, amount: amount, balance: tenant.balance)
  end
end
