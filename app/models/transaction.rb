class Transaction < ApplicationRecord
  belongs_to :invoice, optional: true
  belongs_to :customer, optional: true
  scope :successful, -> {where(result: "success")}
end
