module InvoiceParams
  private

  def invoice_params
    params.permit(:id, :status, :customer_id, :merchant_id, :updated_at, :created_at)
  end
end
