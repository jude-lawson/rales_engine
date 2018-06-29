class Api::V1::MerchantsController < ApplicationController
  include MerchantParams

  def index
    render json: Merchant.all
  end

  def show
    render json: Merchant.find(merchant_params[:id])
  end
end
