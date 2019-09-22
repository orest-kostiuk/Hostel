# frozen_string_literal: true

class Block < ApplicationRecord
  belongs_to :floor
  has_many :rooms

  def available?
    result = rooms.map(&:available?)
    result.include?(true)
  end

  def to_s
    "Block ##{id}"
  end
end
