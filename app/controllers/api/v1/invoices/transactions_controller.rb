class Api::V1::Invoices::TransactionsController < ApplicationController
  include InvoiceParams
  
  def index
    render json: Invoice.find(invoice_params[:id]).transactions
  end
end
