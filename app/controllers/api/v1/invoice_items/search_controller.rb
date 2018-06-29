class Api::V1::InvoiceItems::SearchController < ApplicationController
  include InvoiceItemParams

  def show
    render json: InvoiceItem.search_result(invoice_item_params)
  end

  def index
    render json: InvoiceItem.search_results(invoice_item_params)
  end
end
