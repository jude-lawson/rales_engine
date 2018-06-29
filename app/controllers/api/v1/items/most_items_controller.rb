class Api::V1::Items::MostItemsController < ApplicationController
  include ItemParams

  def index
    render json: Item.most_items(item_params)
  end
end
