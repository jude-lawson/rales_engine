class Api::V1::Items::SearchController < ApplicationController
  include ItemParams

  def show
    render json: Item.search_result(item_params)
  end

  def index
    render json: Item.search_results(item_params)
  end
end
