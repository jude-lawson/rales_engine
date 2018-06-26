class Api::V1::Customers::RandomController < ApplicationController
  def show
    render json: Customer.random_record
  end
end
