class Api::V1::Transactions::SearchController < ApplicationController
  include TransactionParams
  
  def show
    render json: Transaction.search_result(transaction_params)
  end

  def index
    render json: Transaction.search_results(transaction_params)
  end
end
