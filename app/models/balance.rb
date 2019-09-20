class Balance < ApplicationRecord
  has_many :payments
  has_many :replenishments
  belongs_to :tenant
end
