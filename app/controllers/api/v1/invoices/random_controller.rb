class Api::V1::Invoices::RandomController < ApplicationController
  def show
    render json: Invoice.order(Arel.sql("RANDOM()")).limit(1).first
  end
end