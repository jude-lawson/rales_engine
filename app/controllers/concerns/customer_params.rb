module CustomerParams
  private
  
  def customer_params
    params.permit(:id, 
                  :customer_id,
                  :first_name,
                  :last_name,
                  :created_at,
                  :updated_at)
  end
end
