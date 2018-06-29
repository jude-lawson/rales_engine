class Api::V1::Merchants::InvoicesController < ApplicationController
  include MerchantParams
  
  def index
    render json: Merchant.find(merchant_params[:merchant_id]).invoices
  end
end
