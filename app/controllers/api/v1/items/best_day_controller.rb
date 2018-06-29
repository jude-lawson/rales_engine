class Api::V1::Items::BestDayController < ApplicationController
  include ItemParams
  
  def show
    render json: {best_day: Invoice.item_best_day(item_params[:id])}
  end
end
