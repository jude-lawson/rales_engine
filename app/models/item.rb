class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  belongs_to :merchant

  # default_scope { order('items.id DESC') }

  def self.most_revenue(quantity = 5)
    select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(:transactions, :invoice_items, :invoices)
      .where(transactions: { result: "success" })
      .order("revenue DESC")
      .group(:id)
      .limit(quantity)
  end

  def self.most_items(params)
    return { "error" => "Please pass in '?quantity=<integer>' to search for a number of most items by rank" } if params.keys.first != 'quantity'
    
    joins(:invoice_items)
      .order('SUM(invoice_items.quantity) DESC')
      .group(:id)
      .limit(params[:quantity])
  end
end
