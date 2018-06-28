class Api::V1::Items::BestDayController < ApplicationController
  def show
    # select invoices.created_at, count(invoices.created_at) as total_day_sales from invoices
    # inner join invoice_items ii on ii.invoice_id=invoices.id
    # inner join items i on ii.item_id=i.id
    # where i.id = 1
    # group by invoices.created_at
    # order by total_day_sales desc
    # limit 1;
    render json: Item.where(item_id: params[:id]).group(:created_at).count(:invoice_id)
  end
end
