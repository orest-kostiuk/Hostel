class Credential < ApplicationRecord

  belongs_to :admin_user, optional: true
  enum name: %i[billing_per_month]
end
