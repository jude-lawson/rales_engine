class Api::V1::Customers::TransactionsController < ApplicationController
  include CustomerParams
  
  def index
    render json: Customer.find(search_params[:customer_id]).transactions
  end
end
