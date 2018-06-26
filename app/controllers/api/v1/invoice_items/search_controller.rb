class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    render json: InvoiceItem.search_result(search_params)
  end

  def index
    render json: InvoiceItem.search_results(search_params)
  end

  private
  def search_params
    params.permit(:id, :quantity, :item_id, :invoice_id, :unit_price, :updated_at, :created_at)
  end
end