module InvoiceItemParams
  private

  def search_params
    params.permit(:id, :quantity, :item_id, :invoice_id, :unit_price, :updated_at, :created_at)
  end
end
