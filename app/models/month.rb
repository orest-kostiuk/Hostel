class Month < ApplicationRecord
  has_many :replenishments
  has_many :billments
end
