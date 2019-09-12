class Floor < ApplicationRecord
  enum side: [ :left, :right ]
  has_many :blocks
end
