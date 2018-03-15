class Transaction < ApplicationRecord
  default_scope {order(:id)}
  belongs_to :invoice, optional: true
  belongs_to :customer, optional: true

  scope :successful, -> {where(result: "success")}
end
