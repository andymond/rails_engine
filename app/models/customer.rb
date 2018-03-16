class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :merchants, through: :invoices

  def self.most_transactions(merchant_id)
    sql = "customers.*, COUNT(transactions.result) AS transaction_count"
    unscoped.select(sql)
      .joins(invoices: [:merchant, :transactions])
      .merge(Transaction.unscoped.successful)
      .where("merchants.id = ?", merchant_id)
      .group(:id)
      .order("transaction_count DESC")
      .limit(1)
  end

  def self.pending_invoices(merchant_id)
    sql = "SELECT customers.* FROM customers
    INNER JOIN invoices ON customers.id = invoices.customer_id
    INNER JOIN transactions ON invoices.id = transactions.invoice_id
    WHERE invoices.merchant_id = ? AND transactions.result = 'failed'
    EXCEPT SELECT customers.* FROM customers
    INNER JOIN invoices ON customers.id = invoices.customer_id
    INNER JOIN transactions ON invoices.id = transactions.invoice_id
    WHERE invoices.merchant_id = ? AND transactions.result = 'success'"
    unscoped.find_by_sql([sql, merchant_id, merchant_id])
  end
end
