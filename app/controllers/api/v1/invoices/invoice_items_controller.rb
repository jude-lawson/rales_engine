class Api::V1::Invoices::InvoiceItemsController < ApplicationController
  include InvoiceParams
  
  def index
    render json: Invoice.find(invoice_params[:id]).invoice_items
  end
end
