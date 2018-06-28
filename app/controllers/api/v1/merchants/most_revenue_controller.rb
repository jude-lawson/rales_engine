class Api::V1::Merchants::MostRevenueController < ApplicationController
  include MerchantParams
  def index
    render json: Merchant.most_revenue(search_params)
  end
end