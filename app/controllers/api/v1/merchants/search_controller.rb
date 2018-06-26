class Api::V1::Merchants::SearchController < ApplicationController
  def show
    if search_params.keys.first == 'created_at'
      parsed_created_date = Date.parse(search_params['created_at'])
      render json: Merchant.where(created_at: (parsed_created_date.beginning_of_day..parsed_created_date.end_of_day)).limit(1).first
    elsif search_params.keys.first == 'updated_at'
      parsed_created_date = Date.parse(search_params['updated_at'])
      render json: Merchant.where(updated_at: (parsed_created_date.beginning_of_day..parsed_created_date.end_of_day)).limit(1).first
    else
      render json: Merchant.find_by(search_params)
    end
  end

  private

  def search_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
