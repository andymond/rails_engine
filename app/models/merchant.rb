class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.revenue
    select("merchants.*, SUM(invoice_item.unit_price * invoice_item.quantity) AS revenue")
      .joins(:invoice_items, :transactions)
      .group(:id)
      .order("revenue DESC")
  end

end
