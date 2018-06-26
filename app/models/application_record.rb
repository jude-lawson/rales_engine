class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search_result(search_params)
    param = search_params.keys.first
    if param == 'created_at' || param == 'updated_at'
      parsed_date = DateTime.parse(search_params[param])
      where(param => parsed_date).limit(1).first
    elsif param == 'unit_price'
      price = (search_params[param].to_f * 100).round(1).to_i
      where(param => price).limit(1).first
    else
      find_by(search_params)
    end
  end

  def self.search_results(search_params)
    param = search_params.keys.first
    if param == 'created_at' || param == 'updated_at'
      parsed_date = DateTime.parse(search_params[param])
      where(param => parsed_date)
    elsif param == 'unit_price'
      price = (search_params[param].to_f * 100).round(1).to_i
      where(param => price)
    else
      where(search_params)
    end
  end

  def self.random_record
    order("RANDOM()").limit(1).first
  end
end
