class Api::V1::Merchants::RevenueByDateController < ApplicationController
  include MerchantParams

  def show
    render json: Merchant.total_revenue_by_date(merchant_params)
  end
end
