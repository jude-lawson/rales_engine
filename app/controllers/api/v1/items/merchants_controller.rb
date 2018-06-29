class Api::V1::Items::MerchantsController < ApplicationController
  include ItemParams

  def show
    render json: Item.find(item_params[:id]).merchant
  end
end
