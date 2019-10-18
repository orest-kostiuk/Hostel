# frozen_string_literal: true

class Balance < ApplicationRecord
  has_many :payments
  has_many :replenishments
  has_many :ready_billings
  belongs_to :tenant

  def to_s
    "Balance ##{id} ₴#{account_balance.round} #{tenant.full_name_present? ? [tenant.last_name, tenant.first_name,
                                                                        tenant.surname].join(' ') : tenant.to_s}"
  end
end
