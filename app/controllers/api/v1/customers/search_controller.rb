class Api::V1::Customers::SearchController < ApplicationController
  include CustomerParams
  
  def show
    render json: Customer.search_result(customer_params)
  end

  def index
    render json: Customer.search_results(customer_params)
  end
end
