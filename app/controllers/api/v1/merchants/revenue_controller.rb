class Api::V1::Merchants::RevenueController < ApplicationController
  include MerchantParams
  
  def show
    if merchant_params[:date]
      result = Merchant.revenue_by_date(merchant_params)
      render json: { revenue: Merchant.convert_to_string(result) }
    else
      result = Merchant.total_revenue(merchant_params)
      render json: { revenue: Merchant.convert_to_string(result) }
    end
  end
end
