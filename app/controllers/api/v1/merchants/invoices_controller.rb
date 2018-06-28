class Api::V1::Merchants::InvoicesController < ApplicationController
  include MerchantParams
  def index
    render json: Merchant.find(search_params[:merchant_id]).invoices
  end
end