# frozen_string_literal: true

class Billment < ApplicationRecord
  belongs_to :admin_user
  belongs_to :month
  has_many :replenishments
  has_many :ready_billings
end
