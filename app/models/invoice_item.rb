class InvoiceItem < ApplicationRecord
  belongs_to :invoice, optional: true
  belongs_to :item, optional: true
end
