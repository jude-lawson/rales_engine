class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  include MerchantParams
  
  def show
    render json: Customer.favorite_customer(merchant_params[:id])
  end
end
