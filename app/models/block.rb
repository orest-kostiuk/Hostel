class Block < ApplicationRecord
  belongs_to :floor
  has_many :rooms

  def available?
    result = rooms.map { |r| r.available? }
    result.include?(true)
  end
end
