class Api::V1::Merchants::RevenueByDateController < ApplicationController
  include MerchantParams

  def show
    result = Merchant.total_revenue_by_date(merchant_params)
    render json: { total_revenue: Merchant.convert_to_string(result) }
  end
end
