class Api::V1::InvoiceItems::ItemsController < ApplicationController
  include InvoiceItemParams

  def show
    render json: InvoiceItem.find(search_params[:id]).item
  end
end
