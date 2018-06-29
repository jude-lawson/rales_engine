class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  include CustomerParams
  
  def show
    render json: Merchant.favorite_merchant_by_customer(search_params)
  end
end
