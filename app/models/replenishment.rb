# frozen_string_literal: true

class Replenishment < ApplicationRecord
  belongs_to :balance
  belongs_to :month, optional: true
  belongs_to :billment, optional: true

  after_create :update_account_balance

  def update_account_balance
    balance.update_column(:account_balance, balance.account_balance + amount)
  end

  def to_s
    "Replenishment ##{id}"
  end
end
