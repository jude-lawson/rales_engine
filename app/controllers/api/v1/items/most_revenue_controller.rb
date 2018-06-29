class Api::V1::Items::MostRevenueController < ApplicationController
  include ItemParams
  
  def index
    render json: Item.most_revenue(item_params[:quantity])
  end
end
