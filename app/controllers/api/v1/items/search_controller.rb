class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: Item.search_result(search_params)
  end

  def index
    render json: Item.search_results(search_params)
  end

  private
  def search_params
    params.permit(:name, :description, :unit_price, :updated_at, :created_at)
  end
end
