class Api::V1::Merchants::RevenueController < ApplicationController
  include MerchantParams
  def show
    if params[:date]
      result = Merchant.revenue_by_date(search_params)
      render json: {revenue: Merchant.convert_to_string(result)}
    else
      result = Merchant.total_revenue(search_params)
      render json: {revenue: Merchant.convert_to_string(result)}
    end
  end
end