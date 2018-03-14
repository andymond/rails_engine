class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices

  def revenue
    select('invoice_items.quantity, invoice_items.unit_price, transactions.result')
    .joins(:invoices)
    .joins(:invoice_items)
    .joins(:transactions)
  end
end
