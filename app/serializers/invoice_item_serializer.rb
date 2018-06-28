class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :invoice_id, :quantity, :unit_price, :item_id

  def unit_price
    ((object.unit_price.to_f) * 0.01).to_s
  end
end
