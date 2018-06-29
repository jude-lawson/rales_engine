module ItemParams
  private

  def item_params
    params.permit(:id, :quantity, :name, :description, :merchant_id, :unit_price, :updated_at, :created_at)
  end
end
