class Api::V1::Merchants::SearchController < ApplicationController
  def show
    # if search_params.keys.include?('created_at') || search_params.keys.include?('updated_at')
    #   Date.parse(search_params.values.first)
    #   require 'pry';binding.pry
    #   render json: { test: 'date test' }
    # else
    #   render json: Merchant.find_by(search_params)
    # end

    if search_params.keys.first == 'created_at'
      search_params['created_at'] = Date.parse()
  end

  private

  def search_params
    params.permit(:id, :name, :created_at)
  end
end
