class Api::V1::Items::BestDayController < ApplicationController
  include ItemParams
  
  def show
    render json: Invoice.item_best_day(item_params[:id])
  end
end
