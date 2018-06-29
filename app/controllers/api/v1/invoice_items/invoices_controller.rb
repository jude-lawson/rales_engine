class Api::V1::InvoiceItems::InvoicesController < ApplicationController
  include InvoiceItemParams

  def show
    render json: InvoiceItem.find(invoice_item_params[:id]).invoice
  end
end
