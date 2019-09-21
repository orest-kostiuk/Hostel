class ReadyBilling < ApplicationRecord
  belongs_to :tenant
  belongs_to :balance
  belongs_to :billment
end
