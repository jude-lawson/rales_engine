class Api::V1::CustomersController < ApplicationController
  include CustomerParams

  def index
    render json: Customer.all
  end

  def show
    render json: Customer.find(customer_params[:id])
  end
end
