class GenerateBilling
  def initialize(month, admin)
    @month = month
    return unless @month
    @billment = admin.billments.create(month: month) if @month
  end

  def call
    get_all_active_orders
    process_billing
  end

  private

  def get_all_active_orders
    @active_order_tenants = TenantOrder.ordered.map { |t_o| t_o.tenant if t_o.tenant }
  end

  def process_billing
    @active_order_tenants.each do |tenant|
      @billment.ready_billings.create(tenant: tenant, amount: Credential.billing_per_month.last.int_value, balance: tenant.balance)
    end
  end
end