class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items do |t|
      t.references :item, foreign_key: true
      t.references :invoice
      t.integer :quantity
      t.integer :unit_price

      t.timestamps
    end
  end
end
