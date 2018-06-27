class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  belongs_to :merchant

  def self.most_revenue(quantity = 5)
    select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue").joins(:transactions, :invoice_items, :invoices).where(transactions: { result: "success" }).order("revenue DESC").group(:id).limit(quantity)
  end
end
