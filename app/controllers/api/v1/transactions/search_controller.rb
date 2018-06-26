class Api::V1::Transactions::SearchController < ApplicationController
  def show
    render json: Transaction.search_result(search_params)
  end

  private

  def search_params
    params.permit(:id)
  end
end
