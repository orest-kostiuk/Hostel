# frozen_string_literal: true

class Tenant < ApplicationRecord
  after_update :check_login_code
  belongs_to :user, optional: true
  has_many :tenant_orders, class_name: 'TenantOrder'
  has_many :rooms, class_name: "Room", through: :tenant_orders
  has_many :ready_billing
  has_one :balance
  after_create :balance_create

  def check_login_code
    return if login_code || user.nil? || !user.the_taxpayer_identification_number

    update_column :login_code, generate_login_code
  end

  def generate_login_code
    code = user.the_taxpayer_identification_number[6..100].reverse << user.id.to_s
    loop do
      code + 1.to_s
      break code unless User.find_by_login_code(code) || Tenant.find_by_login_code(code)
    end
  end

  def balance_create
    create_balance unless balance
  end

  def full_name_present?
    !first_name.blank? && !last_name.blank? && !surname.blank?
  end

  def full_name
    [first_name, last_name, surname].join(' ')
  end

  def to_s
    "Tenant ##{id}"
  end
end
