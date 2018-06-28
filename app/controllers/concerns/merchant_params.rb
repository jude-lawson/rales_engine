module MerchantParams
  def search_params
    params.permit(:id, :name, :created_at, :updated_at, :date, :quantity, :merchant_id)
  end
end