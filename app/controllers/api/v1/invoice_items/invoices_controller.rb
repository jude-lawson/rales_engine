class Api::V1::InvoiceItems::InvoicesController < ApplicationController
  include InvoiceItemParams

  def show
    render json: InvoiceItem.find(search_params[:id]).invoice
  end
end
