# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :balance
  after_create :update_account_balance

  def update_account_balance
    balance.update_column(:account_balance, balance.account_balance - amount)
  end
end
