class Balance < ApplicationRecord
  has_many :payments
  has_many :replenishments
  has_many :ready_billings
  belongs_to :tenant

  def total_to_pay
    if account_balance <= 0
      (account_balance - ready_billings.map { |r_b| r_b.amount if r_b.amount > 0 }.sum) * -1
    else
      ready_billings.map { |r_b| r_b.amount if r_b.amount > 0 }.sum
    end
  end
end
