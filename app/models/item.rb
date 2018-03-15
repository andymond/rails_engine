class Item < ApplicationRecord
  default_scope {order(:id)}
  scope :random, -> {order('random()').limit(1)}
  belongs_to :merchant, optional: true
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity)
    unscoped.select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(:invoice_items, invoices: [:transactions])
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order("revenue DESC")
      .limit(quantity)
  def self.most_items(limit)
    unscoped.select("items.*, sum(invoice_items.quantity) as number_sold")
    .joins(:invoice_items, :invoices)
    .joins(invoice_items: [invoice: [:transactions]])
    .merge(Transaction.unscoped.successful)
    .order("number_sold desc")
    .group(:id)
    .limit(limit)
  end
end
