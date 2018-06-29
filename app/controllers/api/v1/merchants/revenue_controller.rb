class Api::V1::Merchants::RevenueController < ApplicationController
  include MerchantParams
  
  def show
    if merchant_params[:date]
      render json: Merchant.revenue_by_date(merchant_params)
    else
      render json: Merchant.total_revenue(merchant_params)
    end
  end
end
