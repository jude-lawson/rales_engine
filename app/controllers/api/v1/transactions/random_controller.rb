class Api::V1::Transactions::RandomController < ApplicationController
  def show
    render json: Transaction.random_record
  end
end
