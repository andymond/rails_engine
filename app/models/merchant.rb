class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def self.revenue
    sql = "merchants.*, SUM(invoice_items.unit_price
           * invoice_items.quantity) AS revenue"
    unscoped.select(sql)
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order("revenue DESC")
  end

  def self.favorite_merchant(customer_id)
    sql = "merchants.*, count(transactions.*)
           as successful_transactions"
    unscoped.select(sql)
      .joins(:invoices)
      .joins(invoices: [:transactions, :customer])
      .merge(Transaction.unscoped.successful)
      .where("customers.id =?", customer_id)
      .order("successful_transactions desc")
      .group(:id)
      .limit(1)
  end

  def self.top_merchants_by_items_sold(limit)
    sql = "merchants.*, sum(invoice_items.quantity) as items_sold"
    unscoped.select(sql)
      .joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.unscoped.successful)
      .order("items_sold desc")
      .group(:id)
      .limit(limit)
  end
end
