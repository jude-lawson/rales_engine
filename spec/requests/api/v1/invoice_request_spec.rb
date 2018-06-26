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
    create_list(:invoice, 5, status: "returned")
    
    get "/api/v1/invoices/find_all?status=#{Invoice.first.status}"

    expect(response).to be_successful
    expect(JSON.parse(response.body).length).to eq(5)
  end

  describe 'Random Finder' do
    it 'should return a random record' do
      create_list(:invoice, 5)

      get '/api/v1/invoices/random.json'

      data = JSON.parse(response.body)

      expect(data.class).to eq(Hash)
      expect(data).to have_key('id')
      expect(data).to have_key('customer_id')
      expect(data).to have_key('merchant_id')
      expect(data).to have_key('status')
      expect(data).to have_key('created_at')
      expect(data).to have_key('updated_at')
    end
  end

end
