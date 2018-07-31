class Invoice < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :merchant, optional: true
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.revenue_by_date(date)
    joins(:invoice_items, :transactions)
      .merge(Transaction.unscoped.successful)
      .where("DATE_TRUNC('day', invoices.created_at) = ?", date.slice(0..9))
      .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.single_merchant_revenue_by_date(date, merchant_id)
    joins(:merchant, :invoice_items, :transactions)
      .merge(Transaction.unscoped.successful)
      .where("merchants.id = ?", merchant_id)
      .where("DATE_TRUNC('day', invoices.created_at) = ?", date.slice(0..9))
      .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.item_best_day(item_id)
    sql = "invoices.*, sum(invoice_items.quantity
           * invoice_items.unit_price) as revenue"
    unscoped.select(sql)
      .joins(:transactions, :invoice_items)
      .merge(Transaction.unscoped.successful)
      .where("invoice_items.item_id = ?", item_id)
      .order("revenue DESC")
      .group(:id)
      .limit(1)
  end

  def self.dates(item_id)
    self.item_best_day(item_id).each do |invoice|
      return invoice.created_at
    end
  end
end
