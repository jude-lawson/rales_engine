class Api::V1::Invoices::TransactionsController < ApplicationController
  include InvoiceParams
  
  def index
    render json: Invoice.find(search_params[:id]).transactions
  end
end
