class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  default_scope { order(:id) }

  def self.item_best_day(item_id)
    unscoped
    .select("invoices.created_at, COUNT(invoices.created_at) AS total_day_sales")
    .joins(:invoice_items, :transactions, :items)
    .where("items.id = ? AND transactions.result = ?", item_id, 'success')
    .group("invoices.created_at, invoices.id")
    .order("total_day_sales DESC")
    .limit(1)
    .first["created_at"]
  end
end
