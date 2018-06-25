require 'rails_helper'

describe "Items API" do
  it 'should return all items' do
    items = create_list(:item, 5)

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
  
  it 'should find a single item based on params' do
    item = create(:item)

    get "/api/v1/items/find?name=#{item.name}"

    expect(response).to be_successful
    expect(JSON.parse(response.body)["name"]).to eq(item.name)
  end

  it 'should find a single item based on params' do
    items = create_list(:item, 5)

    get "/api/v1/items/find_all?unit_price=#{Item.first.unit_price}"

    expect(response).to be_successful
    expect(JSON.parse(response.body).length).to eq(5)
  end
end
