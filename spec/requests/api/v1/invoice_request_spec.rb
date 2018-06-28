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

  describe 'Relationship Endpoints' do
    describe '/api/v1/invoices/:id/transactions' do
      it 'should return a collection of associated transactions' do
        create(:customer)
        create(:merchant)
        invoice = create(:invoice)
        sad_invoice = create(:invoice)
        transactions = create_list(:transaction, 2, invoice_id: invoice.id)
        sad_transactions = create_list(:transaction, 2, invoice_id: sad_invoice.id)

        get "/api/v1/invoices/#{invoice.id}/transactions"

        data = JSON.parse(response.body)

        expect(data).to eq(json_without_time(transactions))
        expect(data).to_not eq(json_without_time(sad_transactions))
      end
    end

    describe '/api/v1/invoices/:id/invoice_items' do
      it 'should return a collection of associated invoice items' do
        create(:customer)
        create(:merchant)
        invoice = create(:invoice)
        sad_invoice = create(:invoice)
        item = create(:item)
        invoice_items = create_list(:invoice_item, 2, invoice_id: invoice.id)
        sad_invoice_items = create_list(:invoice_item, 2, invoice_id: sad_invoice.id)

        get "/api/v1/invoices/#{invoice.id}/invoice_items"

        data = JSON.parse(response.body)

        expect(data).to eq(json_without_time(invoice_items))
        expect(data).to_not eq(json_without_time(sad_invoice_items))
      end
    end

    describe '/api/v1/invoices/:id/items' do
      it 'should return a collection of all related items' do
        create(:customer)
        create(:merchant)
        item = create(:item)
        another_item = create(:item)
        invoice = create(:invoice)
        invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
        another_invoice_item = create(:invoice_item, item_id: another_item.id, invoice_id: invoice.id)

        sad_item = create(:item)
        sad_invoice = create(:invoice)
        sad_invoice_item = create(:invoice_item, item_id: sad_item.id, invoice_id: sad_invoice.id)

        get "/api/v1/invoices/#{invoice.id}/items"

        data = JSON.parse(response.body)
        
        expect(data).to eq(json_without_time([item, another_item]))
        expect(data).to_not eq(json_without_time([sad_item]))
      end
    end

    describe '/api/v1/invoices/:id/customer' do
      it 'should return the invoice\'s associated customer' do
        customer = create(:customer)
        create(:merchant)
        create(:item)
        invoice = create(:invoice, customer_id: customer.id)

        sad_customer = create(:customer)
        sad_invoice = create(:invoice, customer_id: sad_customer.id)

        get "/api/v1/invoices/#{invoice.id}/customer"

        data = JSON.parse(response.body)

        expect(data).to eq(json_without_time(customer))
        expect(data).to_not eq(json_without_time(sad_customer))
      end
    end

    describe '/api/v1/invoices/:id/merchant' do
      it 'should return the invoice\'s associated merchant' do
        create(:customer)
        merchant = create(:merchant)
        create(:item)
        invoice = create(:invoice, merchant_id: merchant.id)

        sad_merchant = create(:merchant)
        sad_invoice = create(:invoice, merchant_id: sad_merchant.id)

        get "/api/v1/invoices/#{invoice.id}/merchant"

        data = JSON.parse(response.body)

        expect(data).to eq(json_without_time(merchant))
        expect(data).to_not eq(json_without_time(sad_merchant))
      end
    end
  end
end
