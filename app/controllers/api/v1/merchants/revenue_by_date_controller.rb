class Api::V1::Merchants::RevenueByDateController < ApplicationController
  def show
    result = ((Merchant.total_revenue_by_date(params[:date]).to_f) * 0.01).to_s
    render json: { total_revenue: result }
  end
end
