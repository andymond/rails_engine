class InvoiceItem < ApplicationRecord
  default_scope {order(:id)}
  scope :random, -> {order('random()').limit(1)}
  belongs_to :invoice, optional: true
  belongs_to :item, optional: true
end
