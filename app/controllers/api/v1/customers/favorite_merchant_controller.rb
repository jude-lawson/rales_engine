class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show
    render json: Merchant.favorite_merchant_by_customer(params[:id].to_i)
  end
end