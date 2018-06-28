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

  it 'should find a single invoice based on quantity' do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"

    expect(response).to be_successful
    expect(JSON.parse(response.body)["quantity"]).to eq(invoice_item.quantity)
  end
  
  it 'should find a single invoice based on id' do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

    expect(response).to be_successful
    expect(JSON.parse(response.body)["quantity"]).to eq(invoice_item.quantity)
  end

  it 'should find all invoice_items based on params' do
    create_list(:invoice_item, 5)

    get "/api/v1/invoice_items/find_all?quantity=#{InvoiceItem.first.quantity}"

    expect(response).to be_successful
    expect(JSON.parse(response.body).length).to eq(5)
  end

  describe 'Random Finder' do
    it 'should return a random record' do
      create_list(:invoice_item, 5)

      get '/api/v1/invoice_items/random.json'

      data = JSON.parse(response.body)

      expect(data.class).to eq(Hash)
      expect(data).to have_key('id')
      expect(data).to have_key('item_id')
      expect(data).to have_key('invoice_id')
      expect(data).to have_key('quantity')
      expect(data).to have_key('unit_price')
      expect(data).to have_key('created_at')
      expect(data).to have_key('updated_at')
    end
  end

  describe 'Relationship Endpoints' do
    describe '/api/v1/invoice_items/:id/invoice' do
      it 'should return the Invoice Item\'s associated invoice' do
        invoice = create(:invoice)
        invoice_item = create(:invoice_item, invoice_id: invoice.id)

        sad_invoice = create(:invoice)
        sad_invoice_item = create(:invoice_item, invoice_id: sad_invoice.id)

        get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

        data = JSON.parse(response.body)

        expect(data).to eq(json_without_time(invoice))
        expect(data).to_not eq(json_without_time(sad_invoice))
      end
    end

    describe '/api/v1/invoice_items/:id/item' do
      it 'should return the Invoice Item\'s associated item' do
        item = create(:item)
        invoice_item = create(:invoice_item, item_id: item.id)

        sad_item = create(:item)
        sad_invoice_item = create(:invoice_item, item_id: sad_item.id)

        get "/api/v1/invoice_items/#{invoice_item.id}/item"

        data = JSON.parse(response.body)

        expect(data).to eq(json_without_time(item))
        expect(data).to_not eq(json_without_time(sad_item))
      end
    end
  end
end
