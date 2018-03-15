class Customer < ApplicationRecord
  default_scope {order(:id)}
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :merchants, through: :invoices

  def self.most_transactions(merchant_id)
    unscoped.select("customers.*, COUNT(transactions.result) AS transaction_count")
      .joins(invoices: [:merchant, :transactions])
      .merge(Transaction.unscoped.successful)
      .where("merchants.id = ?", merchant_id)
      .group(:id)
      .order("transaction_count DESC")
      .limit(1)
  end
end
