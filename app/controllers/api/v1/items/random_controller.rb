class Api::V1::Items::RandomController < ApplicationController
  def show
    render json: Item.order(Arel.sql("RANDOM()")).limit(1).first
  end
end