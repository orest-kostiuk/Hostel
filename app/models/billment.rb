# frozen_string_literal: true

class Billment < ApplicationRecord
  belongs_to :admin_user
  belongs_to :month
  has_many :replenishments
  has_many :ready_billings

  def to_s
    "Billment ##{id}"
  end

  def self.take_object(date)
    all.map { |b| b if b.date_done.at_beginning_of_month == date}.first
  end
end
