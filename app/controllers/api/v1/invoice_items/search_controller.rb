class Api::V1::InvoiceItems::SearchController < ApplicationController
  include InvoiceItemParams

  def show
    render json: InvoiceItem.search_result(search_params)
  end

  def index
    render json: InvoiceItem.search_results(search_params)
  end
end
