class UpdateTenantInformation
  def initialize(u, tenant)
    @user = u
    @tenant = tenant
  end

  def process
    update_information
  end

  private

  def update_information
    @user.assign_attributes(first_name: @tenant.first_name,
                        surname: @tenant.surname,
                        last_name: @tenant.last_name,
                        index: @tenant.index,
                        region: @tenant.region,
                        district: @tenant.district,
                        city: @tenant.city,
                        street: @tenant.street,
                        house_number: @tenant.house_number,
                        passport_series: @tenant.passport_series,
                        who_issued_the_passport: @tenant.who_issued_the_passport,
                        when_issued_the_passport: @tenant.when_issued_the_passport,
                        the_taxpayer_identification_number: @tenant.the_taxpayer_identification_number,
                        phone_number: @tenant.phone_number,
                        account_status: 1)
    @tenant.user = @user
  end
end