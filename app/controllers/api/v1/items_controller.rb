class Api::V1::ItemsController < ApplicationController
  include ItemParams
  
  def index
    render json: Item.all
  end

  def show
    render json: Item.find(item_params[:id])
  end
end
