class Api::V1::Invoices::InvoiceItemsController < ApplicationController
  include InvoiceParams
  
  def index
    render json: Invoice.find(search_params[:id]).invoice_items
  end
end
