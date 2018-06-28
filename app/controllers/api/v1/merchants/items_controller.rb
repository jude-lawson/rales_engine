class Api::V1::Merchants::ItemsController < ApplicationController
  include MerchantParams
  def show
    render json: Merchant.find(search_params[:merchant_id]).items
  end
end
