class Api::V1::Invoices::ItemsController < ApplicationController
  include InvoiceParams
  
  def index
    render json: Invoice.find(invoice_params[:id]).items
  end
end
