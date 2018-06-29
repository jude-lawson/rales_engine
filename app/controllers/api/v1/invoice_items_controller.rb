class Api::V1::InvoiceItemsController < ApplicationController
  include InvoiceItemParams
  
  def index
    render json: InvoiceItem.all
  end

  def show
    render json: InvoiceItem.find(invoice_item_params[:id])
  end
end
