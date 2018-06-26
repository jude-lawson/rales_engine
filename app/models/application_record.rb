class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search_result(search_params)
    param = search_params.keys.first
    if param == 'created_at' || param == 'updated_at'
      parsed_created_date = Date.parse(search_params[param])
      where(param => (parsed_created_date.beginning_of_day..parsed_created_date.end_of_day)).limit(1).first
    else
      find_by(search_params)
    end
  end

  def self.search_results(search_params)
    param = search_params.keys.first
    if param == 'created_at' || param == 'updated_at'
      parsed_created_date = Date.parse(search_params[param])
      where(param => (parsed_created_date.beginning_of_day..parsed_created_date.end_of_day))
    else
      where(search_params)
    end
  end
end
