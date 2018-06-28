class Api::V1::Merchants::SearchController < ApplicationController
  include MerchantParams
  def show
    render json: Merchant.search_result(search_params)
  end

  def index
    render json: Merchant.search_results(search_params)
  end
end
