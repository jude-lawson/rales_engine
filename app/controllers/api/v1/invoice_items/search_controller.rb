class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    if request.env["PATH_INFO"].include?("random")
      render json: InvoiceItem.order("random").take(1)
    else
      render json: InvoiceItem.search_result(search_params)
    end
  end

  def index
    render json: InvoiceItem.search_results(search_params)
  end

  private
  def search_params
    params.permit(:quantity, :item_id, :invoice_id, :unit_price, :updated_at, :created_at)
  end
end