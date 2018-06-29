class Api::V1::Merchants::MostItemsController < ApplicationController
  include MerchantParams
  
  def index
    render json: Merchant.most_items(merchant_params)
  end
end
