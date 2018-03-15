class Invoice < ApplicationRecord
  default_scope {order(:id)}
  scope :random, -> {order('random()').limit(1)}
  belongs_to :customer, optional: true
  belongs_to :merchant, optional: true
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.revenue_by_date(date)
    joins(:invoice_items, :transactions)
      .merge(Transaction.unscoped.successful)
      .where("date_trunc('day', invoices.created_at) = ?", date)
      .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.item_best_day(item_id)
    unscoped.select("invoices.*, sum(invoice_items.quantity
                    * invoice_items.unit_price) as revenue")
      .joins(:transactions, :invoice_items)
      .merge(Transaction.unscoped.successful)
      .where("invoice_items.item_id = ?", item_id)
      .order("revenue desc")
      .group(:id)
      .limit(1)
  end

  def self.dates(item_id)
    self.item_best_day(item_id).each do |invoice|
      return invoice.created_at
    end
  end
end
