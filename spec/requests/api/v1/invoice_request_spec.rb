require 'rails_helper'

describe "Invoices API" do
  it 'should return all invoices' do
    create_list(:invoice, 5)

    get '/api/v1/invoices.json'

    expect(response).to be_successful
    expect(JSON.parse(response.body).length).to eq(5)
  end

  it 'should return one invoice' do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}.json"

    expect(response).to be_successful

    returned_invoice = JSON.parse(response.body)

    expect(returned_invoice["status"]).to eq(invoice.status)
  end

  it 'should find a single invoice based on params' do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?status=#{invoice.status}"

    expect(response).to be_successful
    expect(JSON.parse(response.body)["status"]).to eq(invoice.status)
  end

  it 'should find all invoices based on params' do
    create_list(:invoice, 5)

    get "/api/v1/invoices/find_all?statuse=#{Invoice.first.status}"

    expect(response).to be_successful
    expect(JSON.parse(response.body).length).to eq(5)
  end
end
