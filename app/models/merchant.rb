class Merchant < ApplicationRecord
  default_scope {order(:id)}
  has_many :items
  has_many :invoices

  def self.revenue
    select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order("revenue DESC")
  end
end
