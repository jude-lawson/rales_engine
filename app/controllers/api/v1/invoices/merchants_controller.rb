class Api::V1::Invoices::MerchantsController < ApplicationController
  include InvoiceParams
  
  def show
    render json: Invoice.find(invoice_params[:id]).merchant
  end
end
