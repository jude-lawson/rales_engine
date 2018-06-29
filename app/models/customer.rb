class Customer < ApplicationRecord
  validates_presence_of :first_name,
                        :last_name
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.pending_invoices(merchant_id_hash)
    find_by_sql " SELECT customers.* FROM customers 
                  INNER JOIN invoices ON invoices.customer_id = customers.id 
                  INNER JOIN merchants ON invoices.merchant_id = merchants.id 
                  INNER JOIN transactions ON invoices.id = transactions.invoice_id 
                  WHERE merchants.id = '#{merchant_id_hash[:id].to_i}'
                  EXCEPT 
                    SELECT customers.* FROM customers 
                    INNER JOIN invoices ON invoices.customer_id = customers.id 
                    INNER JOIN merchants ON invoices.merchant_id = merchants.id 
                    INNER JOIN transactions ON invoices.id = transactions.invoice_id 
                    WHERE transactions.result = 'success' AND merchants.id = '#{merchant_id_hash[:id].to_i}'"
  end

  def self.favorite_customer(merchant_id)
    select("customers.*")
    .joins(:invoices, :transactions, :merchants)
    .where("merchants.id = ? AND transactions.result = ?", merchant_id, 'success')
    .group(:id)
    .order(Arel.sql("COUNT(transactions.id) DESC"))
    .limit(1)
    .first
  end
end
