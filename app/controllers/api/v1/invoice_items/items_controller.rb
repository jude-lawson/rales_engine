class Api::V1::InvoiceItems::ItemsController < ApplicationController
  include InvoiceItemParams

  def show
    render json: InvoiceItem.find(invoice_item_params[:id]).item
  end
end
