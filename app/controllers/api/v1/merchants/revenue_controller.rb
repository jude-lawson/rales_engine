class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    if params[:date]
      result = Merchant.revenue_by_date(params[:date], params[:id])
      render json: {revenue: Merchant.convert_to_string(result)}
    else
      result = Merchant.total_revenue(params[:id])
      render json: {revenue: Merchant.convert_to_string(result)}
    end
  end
end