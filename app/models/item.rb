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
  end
end
