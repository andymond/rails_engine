class Merchant < ApplicationRecord
  default_scope {order(:id)}
  has_many :items
  has_many :invoices

  def self.revenue
    unscoped.select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order("revenue DESC")
  end

  def self.favorite_merchant(customer_id)
    unscoped.select("merchants.*, count(transactions.*) as successful_transactions")
    .joins(:invoices)
    .joins(invoices: [:transactions, :customer])
    .merge(Transaction.unscoped.successful)
    .where("customers.id =?", customer_id)
    .order("successful_transactions desc")
    .group(:id)
    .limit(1)
  end
end
