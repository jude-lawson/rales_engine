class Customer < ApplicationRecord
  validates_presence_of :first_name,
                        :last_name
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.pending_invoices(merchant_id)
    find_by_sql " SELECT customers.* FROM customers 
                  INNER JOIN invoices ON invoices.customer_id = customers.id 
                  INNER JOIN merchants ON invoices.merchant_id = merchants.id 
                  INNER JOIN transactions ON invoices.id = transactions.invoice_id 
                  WHERE merchants.id = #{merchant_id}
                  EXCEPT 
                    SELECT customers.* FROM customers 
                    INNER JOIN invoices ON invoices.customer_id = customers.id 
                    INNER JOIN merchants ON invoices.merchant_id = merchants.id 
                    INNER JOIN transactions ON invoices.id = transactions.invoice_id 
                    WHERE transactions.result = 'success' AND merchants.id = #{merchant_id}"
  end
end
