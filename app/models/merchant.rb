class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.favorite_merchant_by_customer(params_hash)
    customer_id = params_hash[:id]

    select("merchants.*")
            .joins(:invoices, :transactions, :customers)
            .where("customers.id = ? AND transactions.result = ?", customer_id, 'success')
            .group(:id)
            .order(Arel.sql("COUNT(transactions.id) DESC"))
            .limit(1)
            .first
  end

  def self.most_revenue(quantity_hash)
    select("merchants.*")
    .joins(:invoices, invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success' })
    .order(Arel.sql("SUM(invoice_items.quantity * invoice_items.unit_price)  DESC"))
    .group(:id)
    .limit(quantity_hash[:quantity].to_i)
  end

  def self.most_items(quantity_hash)
    select("merchants.*")
    .joins(:invoices, invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success' })
    .order("SUM(invoice_items.quantity)  DESC")
    .group(:id)
    .limit(quantity_hash[:quantity].to_i)
  end

  def self.total_revenue_by_date(date_hash)
    result = joins(:invoices, invoices: [:invoice_items, :transactions])
              .where(transactions: {result: 'success' })
              .where(invoices: { created_at: date_hash[:date].to_date.beginning_of_day..date_hash[:date].to_date.end_of_day })
              .sum("invoice_items.quantity * invoice_items.unit_price")

    { total_revenue: convert_to_string(result) }
  end

  def self.total_revenue(merchant_id_hash)
    result = joins(:invoices, invoices: [:invoice_items, :transactions])
              .where(transactions: {result: 'success' })
              .where("merchants.id = ?", merchant_id_hash[:id].to_i)
              .sum("invoice_items.quantity * invoice_items.unit_price")

    { revenue: convert_to_string(result) }
  end

  def self.revenue_by_date(params_hash)
    result = joins(:invoices, invoices: [:invoice_items, :transactions])
              .where(transactions: {result: 'success' })
              .where("merchants.id = ?", params_hash[:id].to_i)
              .where(invoices: { created_at: params_hash[:date].to_date.beginning_of_day..params_hash[:date].to_date.end_of_day })
              .sum("invoice_items.quantity * invoice_items.unit_price")

    { revenue: convert_to_string(result) }
  end
end
