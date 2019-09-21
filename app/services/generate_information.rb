# frozen_string_literal: true

class GenerateInformation
  def initialize(u)
    @user = u
  end

  def process
    create_tenant
  end

  private

  def create_tenant
    @user.create_tenant(first_name: @user.first_name,
                        surname: @user.surname,
                        last_name: @user.last_name,
                        index: @user.index,
                        region: @user.region,
                        district: @user.district,
                        city: @user.city,
                        street: @user.street,
                        house_number: @user.house_number,
                        passport_series: @user.passport_series,
                        who_issued_the_passport: @user.who_issued_the_passport,
                        when_issued_the_passport: @user.when_issued_the_passport,
                        the_taxpayer_identification_number: @user.the_taxpayer_identification_number,
                        phone_number: @user.phone_number)
  end
end
