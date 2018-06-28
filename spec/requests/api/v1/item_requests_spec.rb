require 'rails_helper'

describe "Items API" do
  it 'should return all items' do
    create_list(:item, 5)
    get '/api/v1/items.json'

    expect(response).to be_successful
    expect(JSON.parse(response.body).length).to eq(5)
  end

  it 'should return one item' do
    item = create(:item)

    get "/api/v1/items/#{item.id}.json"

    expect(response).to be_successful

    returned_item = JSON.parse(response.body)

    expect(returned_item["name"]).to eq(item.name)
    expect(returned_item["description"]).to eq(item.description)
    expect(returned_item["unit_price"]).to eq(item.unit_price)
  end

  it 'should find a single item based on params' do
    item = create(:item)

    get "/api/v1/items/find?name=#{item.name}"

    expect(response).to be_successful
    expect(JSON.parse(response.body)["name"]).to eq(item.name)
  end

  it 'should find all items based on params' do
    create_list(:item, 5)

    get "/api/v1/items/find_all?unit_price=#{Item.first.unit_price}"

    expect(response).to be_successful
    expect(JSON.parse(response.body).length).to eq(5)
  end

  describe 'Random Finder' do
    it 'should return a random record' do
      create_list(:item, 5)

      get '/api/v1/items/random.json'

      data = JSON.parse(response.body)

      expect(data.class).to eq(Hash)
      expect(data).to have_key('id')
      expect(data).to have_key('name')
      expect(data).to have_key('description')
      expect(data).to have_key('unit_price')
      expect(data).to have_key('merchant_id')
      expect(data).to have_key('created_at')
      expect(data).to have_key('updated_at')
    end
  end

  describe 'Item Relationship Endpoints' do
    describe '/api/v1/items/:id/invoice_items' do
      it 'should return a collection of associated invoice items' do
        item = create(:item, id: 2)
        create(:item, id: 1)
        invoice_items = create_list(:invoice_item, 2, item_id: 2)
        sad_invoice_item = create(:invoice_item, item_id: 1)

        get "/api/v1/items/#{item.id}/invoice_items"

        data = JSON.parse(response.body)

        expect(data).to eq(json_with_soft_time(invoice_items))
        expect(data).to_not eq(json_with_soft_time(sad_invoice_item))
      end
    end

    describe '/api/v1/items/:id/merchant' do
      it 'should return the associated merchant record' do
        merchant = create(:merchant, id: 2)
        sad_merchant = create(:merchant, id: 1)
        item = create(:item, merchant_id: 2)
        create(:item, merchant_id: 1 )

        get "/api/v1/items/#{item.id}/merchant"

        data = JSON.parse(response.body)

        expect(data).to eq(json_with_soft_time(merchant))
        expect(data).to_not eq(json_with_soft_time(sad_merchant))
      end
    end
  end

  describe 'Business Intelligence Endpoints' do
    describe '/api/v1/items/most_revenue?quantity=x' do
      it 'should show a collection of items with most revenue ranked by total revenue' do
        merchant = create(:merchant)
        customer = create(:customer)
        invoice_list = create_list(:invoice, 5, merchant: merchant, customer: customer)
        item1 = Item.create!(name: "Thing", description: "Things", unit_price: 1500, merchant_id: merchant.id)
        item2 = Item.create!(name: "Thing2", description: "Things", unit_price: 2000, merchant_id: merchant.id)
        item3 = Item.create!(name: "Thing3", description: "Things", unit_price: 2500, merchant_id: merchant.id)
        item4 = Item.create!(name: "Thing4", description: "Things", unit_price: 1500, merchant_id: merchant.id)
        create(:invoice_item, item: item1, unit_price: item1.unit_price, quantity: 10, invoice: invoice_list[0])
        create(:invoice_item, item: item2, unit_price: item2.unit_price, quantity: 10, invoice: invoice_list[1])
        create(:invoice_item, item: item3, unit_price: item3.unit_price, quantity: 10, invoice: invoice_list[2])
        create(:invoice_item, item: item4, unit_price: item4.unit_price, quantity: 10, invoice: invoice_list[3])
        create(:transaction, invoice: invoice_list[0])
        create(:transaction, invoice: invoice_list[1])
        create(:transaction, invoice: invoice_list[2])
        create(:transaction, invoice: invoice_list[3], result: "failed")

        get '/api/v1/items/most_revenue?quantity=4'

        expect(response_data.count).to eq(3)
        expect(response_data.first["name"]).to eq(item3.name)
        expect(response_data.last["name"]).to eq(item1.name)
        expect(response_data[1]["name"]).to eq(item2.name)
      end
    end

    describe '/api/v1/items/most_items?quantity=x' do
      it 'should return a quantity of items ranked by the total number sold' do
        create(:merchant)
        create(:customer)
        invoice = create(:invoice)
        invoice2 = create(:invoice)
        item1 = create(:item)
        item2 = create(:item)
        sad_item = create(:item)
        create(:transaction, invoice: invoice)
        create(:transaction, invoice: invoice2)
        create(:invoice_item, item: item1, quantity: 10, invoice: invoice)
        create(:invoice_item, item: item1, quantity: 9, invoice: invoice)
        create(:invoice_item, item: item1, quantity: 8, invoice: invoice)
        create(:invoice_item, item: item2, quantity: 7, invoice: invoice2)
        create(:invoice_item, item: item2, quantity: 6, invoice: invoice2)
        create(:invoice_item, item: item2, quantity: 5, invoice: invoice2)

        create(:invoice_item, item: sad_item, quantity: 4)
        create(:invoice_item, item: sad_item, quantity: 3)
        create(:invoice_item, item: sad_item, quantity: 2)
        create(:invoice_item, item: sad_item, quantity: 1)

        get '/api/v1/items/most_items?quantity=2'

        expect(response_data).to eq(json_with_soft_time([item1, item2]))
        expect(response_data).to_not eq(json_with_soft_time([sad_item]))
      end

      it 'should return error message if quantity param is not provided' do
        get '/api/v1/items/most_items?number=2'

        error_message = { "error" => "Please pass in '?quantity=<integer>' to search for a number of most items by rank" }.as_json

        expect(response_data).to eq(error_message)
      end
    end

    describe '/api/v1/items/:id/best_day' do
      xit 'should return the most recent date with the most sales for the given item using the invoice date' do
        # Sell two of item today
        item = create(:item)
        invoice = create(:invoice)
        invoice2 = create(:invoice)
        invoice_item = create(:invoice_item, quantity: 1, invoice: invoice, item: item)
        invoice_item2 = create(:invoice_item, quantity: 1, invoice: invoice2, item: item)
        create(:transaction, invoice: invoice)
        create(:transaction, invoice: invoice2)

        # Same item, but an unsuccessful couple of transactions
        failed_invoice = create(:invoice)
        failed_invoice2 = create(:invoice)
        failed_invoice_item = create(:invoice_item, quantity: 1, invoice: failed_invoice, item: item)
        failed_invoice_item2 = create(:invoice_item, quantity: 1, invoice: failed_invoice2, item: item)
        create(:transaction, invoice: failed_invoice)
        create(:transaction, invoice: failed_invoice2)

        # Sell two of item1 yesterday
        earlier_invoice = create(:invoice, created_at: DateTime.yesterday)
        earlier_invoice2 = create(:invoice, created_at: DateTime.yesterday)
        earlier_invoice_item = create(:invoice_item, quantity: 1, invoice: earlier_invoice, item: item)
        earlier_invoice_item = create(:invoice_item, quantity: 1, invoice: earlier_invoice2, item: item)
        create(:transaction, invoice: earlier_invoice, result: 'failed')
        create(:transaction, invoice: earlier_invoice2, result: 'failed')

        # Sell 1 of item2 today
        sad_item = create(:item)
        sad_invoice = create(:invoice)
        sad_invoice_item = create(:invoice_item, quantity: 1, invoice: sad_invoice, item: sad_item)
        create(:transaction, invoice: sad_invoice)

        best_day = invoice2.created_at.iso8601(fraction_digits=3)
        earlier_day = earlier_invoice.created_at.iso8601(fraction_digits=3)

        get "/api/v1/items/#{item.id}/best_day"
        
        expect(response_data).to eq({best_day: best_day}.as_json)
        expect(response_data).to_not eq({best_day: earlier_day}.as_json)
      end
    end
  end
end
