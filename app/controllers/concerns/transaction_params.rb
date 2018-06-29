module TransactionParams
  private

  def transaction_params
    params.permit(:id, :transaction_id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at)
  end
end
