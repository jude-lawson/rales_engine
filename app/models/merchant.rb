class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.favorite_merchant_by_customer(customer_id)
    select("merchants.*")
            .joins(:invoices, :transactions, :customers)
            .where("customers.id = ? AND transactions.result = ?", customer_id, 'success')
            .group(:id)
            .order("COUNT(transactions.id) DESC")
            .limit(1)
            .first
  end

  def self.most_revenue(quantity)
    select("merchants.*")
    .joins(:invoices, invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success' })
    .order("SUM(invoice_items.quantity * invoice_items.unit_price)  DESC")
    .group(:id)
    .limit(quantity)
  end

  def self.most_items(quantity)
    select("merchants.*")
    .joins(:invoices, invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success' })
    .order("SUM(invoice_items.quantity)  DESC")
    .group(:id)
    .limit(quantity)
  end

  def self.total_revenue_by_date(date)
    joins(:invoices, invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success' })
    .where(invoices: { created_at: date.to_date.beginning_of_day..date.to_date.end_of_day })
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end
end
