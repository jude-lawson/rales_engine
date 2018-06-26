require 'rails_helper'

describe "Invoice_items API" do
  it 'should return all invoice_items' do
    create_list(:invoice_item, 5)

    get '/api/v1/invoice_items.json'

    expect(response).to be_successful
    expect(JSON.parse(response.body).length).to eq(5)
  end

  it 'should return one invoice' do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}.json"

    expect(response).to be_successful

    returned_invoice_item = JSON.parse(response.body)
    expect(returned_invoice_item["quantity"]).to eq(invoice_item.quantity)
  end

  it 'should find a single invoice based on params' do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"

    expect(response).to be_successful
    expect(JSON.parse(response.body)["quantity"]).to eq(invoice_item.quantity)
  end

  it 'should find all invoice_items based on params' do
    create_list(:invoice_item, 5)

    get "/api/v1/invoice_items/find_all?quantity=#{InvoiceItem.first.quantity}"

    expect(response).to be_successful
    expect(JSON.parse(response.body).length).to eq(5)
  end
end