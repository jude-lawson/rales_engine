class Api::V1::Invoices::SearchController < ApplicationController
  include InvoiceParams
  
  def show
    render json: Invoice.search_result(invoice_params)
  end

  def index
    render json: Invoice.search_results(invoice_params)
  end
end
