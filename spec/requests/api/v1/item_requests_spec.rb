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
end
