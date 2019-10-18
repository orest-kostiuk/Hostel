# frozen_string_literal: true

class ReadyBilling < ApplicationRecord
  belongs_to :tenant
  belongs_to :balance
  belongs_to :billment
  after_create :create_payment

  def to_s
    "ReadyBilling ##{id}"
  end

  def create_payment
      balance.payments.create(date_payed: created_at, amount: amount)
      paid!
  end

  def paid!
    update_attribute :is_paid, true
  end
end
