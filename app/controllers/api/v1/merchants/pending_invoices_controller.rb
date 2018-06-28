class Api::V1::Merchants::PendingInvoicesController < ApplicationController
  include MerchantParams
  def index
    render json: Customer.pending_invoices(search_params)
  end
end