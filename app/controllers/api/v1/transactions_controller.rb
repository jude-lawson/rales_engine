class Api::V1::TransactionsController < ApplicationController
  include TransactionParams

  def index
    render json: Transaction.all
  end

  def show
    render json: Transaction.find(transaction_params[:id])
  end
end
