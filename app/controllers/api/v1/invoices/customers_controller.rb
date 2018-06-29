class Api::V1::Invoices::CustomersController < ApplicationController
  include InvoiceParams
  
  def show
    render json: Invoice.find(search_params[:id]).customer
  end
end
