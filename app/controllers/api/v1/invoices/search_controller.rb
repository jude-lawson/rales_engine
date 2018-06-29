class Api::V1::Invoices::SearchController < ApplicationController
  include InvoiceParams
  
  def show
    render json: Invoice.search_result(search_params)
  end

  def index
    render json: Invoice.search_results(search_params)
  end

  # private
  # def search_params
  #   params.permit(:id, :status, :customer_id, :merchant_id, :updated_at, :created_at)
  # end
end
