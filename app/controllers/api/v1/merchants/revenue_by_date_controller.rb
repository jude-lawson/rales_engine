class Api::V1::Merchants::RevenueByDateController < ApplicationController
  def show
    result = Merchant.total_revenue_by_date(params[:date])
    render json: { total_revenue: Merchant.convert_to_string(result) }
  end
end
