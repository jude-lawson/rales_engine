module InvoiceParams
  private

  def search_params
    params.permit(:id, :status, :customer_id, :merchant_id, :updated_at, :created_at)
  end
end
