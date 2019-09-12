class Tenant < ApplicationRecord
  after_update :check_login_code
  belongs_to :user
  has_many :tenant_orders
  has_many :rooms, through: :tenant_orders

  def check_login_code
    return if login_code || user.nil? || !user.the_taxpayer_identification_number
    update_column :login_code, generate_login_code
  end
  def generate_login_code
    loop do
      code = user.the_taxpayer_identification_number[6..100].reverse << user.id.to_s + 1.to_s
      break code unless User.find_by_login_code(code) || Tenant.find_by_login_code(code)
    end
  end
end
