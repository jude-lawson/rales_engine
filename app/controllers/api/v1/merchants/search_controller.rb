class Api::V1::Merchants::SearchController < ApplicationController
  include MerchantParams
  
  def show
    render json: Merchant.search_result(merchant_params)
  end

  def index
    render json: Merchant.search_results(merchant_params)
  end
end
