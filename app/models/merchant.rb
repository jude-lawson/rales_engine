class Merchant < ApplicationRecord
  validates_presence_of :name

  def self.search_result(search_params)
    param = search_params.keys.first
    if param == 'created_at' || param == 'updated_at'
      parsed_created_date = Date.parse(search_params[param])
      Merchant.where(param => (parsed_created_date.beginning_of_day..parsed_created_date.end_of_day)).limit(1).first
    else
      Merchant.find_by(search_params)
    end
  end

  def self.search_results(search_params)
    if search_params.keys.first == 'created_at' || search_params.keys.first == 'updated_at'
      parsed_created_date = Date.parse(search_params[search_params.keys.first])
      Merchant.where(created_at: (parsed_created_date.beginning_of_day..parsed_created_date.end_of_day))
    else
      Merchant.where(search_params)
    end
  end
end
