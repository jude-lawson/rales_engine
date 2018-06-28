class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.favorite_merchant_by_customer(customer_id)
    Merchant.select("merchants.*")
                    .joins(:invoices, :transactions, :customers)
                    .where("customers.id = ? AND transactions.result = ?", customer_id, 'success')
                    .group(:id)
                    .order("COUNT(transactions.id) DESC")
                    .limit(1)
                    .first
  end
end
