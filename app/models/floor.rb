# frozen_string_literal: true

class Floor < ApplicationRecord
  enum side: %i[left right]
  has_many :blocks
end
