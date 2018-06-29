class Api::V1::Customers::SearchController < ApplicationController
  include CustomerParams
  
  def show
    render json: Customer.search_result(search_params)
  end

  def index
    render json: Customer.search_results(search_params)
  end
end
