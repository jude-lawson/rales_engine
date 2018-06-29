class Api::V1::InvoicesController < ApplicationController
  include InvoiceParams

  def index
    render json: Invoice.all
  end

  def show
    render json: Invoice.find(invoice_params[:id])
  end
end
