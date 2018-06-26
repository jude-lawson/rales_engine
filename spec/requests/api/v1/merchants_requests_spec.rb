require 'rails_helper'

RSpec.describe 'Merchants Endpoints' do
  before :each do
    @date = "2018-06-26T21:25:04.512Z"
    merchant1 = Merchant.create(name: "Merchant", created_at: @date, updated_at: @date)
    merchant2 = Merchant.create(name: "Merchant", created_at: @date, updated_at: @date)
    @merchants = [merchant1, merchant2]
  end

  describe 'Accesing the index endpoint' do
    it 'should return all merchant records' do
      get '/api/v1/merchants.json'

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@merchants))
    end
  end

  describe 'Accessing the show endpoint' do
    it 'should return a single merchant\'s record' do
      merchant = @merchants.first
      get "/api/v1/merchants/#{merchant.id}.json"

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(merchant))
    end
  end

  context 'Single Record Finder' do
    it 'should be able to return a single record by its id' do
      get "/api/v1/merchants/find?id=#{@merchants[1].id}"

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@merchants[1]))
    end

    it 'should be able to return a single record by its name' do
      get "/api/v1/merchants/find?name=#{@merchants[0].name}"

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@merchants[0]))
    end

    it 'should be able to return a single record by its created_at datetime' do
      early_merchant = Merchant.create!(name: 'Early Merchant', created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC')
      get "/api/v1/merchants/find?created_at=#{@date}"
      
      data = JSON.parse(response.body)
      
      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@merchants[0]))
      expect(data).to_not eq(json_with_soft_time(early_merchant))
    end
    
    it 'should be able to return an single record by its updated_at datetime' do
      early_merchant = Merchant.create!(name: 'Early Merchant', created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC')

      get "/api/v1/merchants/find?updated_at=#{@date}"

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@merchants[0]))
      expect(data).to_not eq(json_with_soft_time(early_merchant))
    end
  end

  describe 'Multiple Finders' do
    it 'should be able to return multiple records by id' do
      get "/api/v1/merchants/find_all?id=#{@merchants[0].id}"

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time([@merchants[0]]))
    end

    it 'should be able to return multiple records by name' do
      a_merchant = Merchant.create!(name: 'Same Name Merchant')
      duplicate_merchant = Merchant.create!(name: 'Same Name Merchant')

      get "/api/v1/merchants/find_all?name=#{a_merchant.name}"

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time([a_merchant, duplicate_merchant]))
      expect(data).to_not eq(json_with_soft_time(@merchants[1]))
    end

    it 'sould be able to return multiple records by created_at' do
      early_merchant = Merchant.create!(name: 'Early Merchant', created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC')

      get "/api/v1/merchants/find_all?created_at=#{@date}"

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@merchants))
      expect(data).to_not eq(json_with_soft_time(early_merchant))
    end

    it 'sould be able to return multiple records by updated_at' do
      early_merchant = Merchant.create!(name: 'Early Merchant', created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC')

      get "/api/v1/merchants/find_all?updated_at=#{@date}"

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@merchants))
      expect(data).to_not eq(json_with_soft_time(early_merchant))
    end
  end

  describe 'Random Finder' do
    it 'should return a random record' do
      get '/api/v1/merchants/random.json'

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data.class).to eq(Hash)
      expect(data).to have_key('id')
      expect(data).to have_key('name')
      expect(data).to have_key('created_at')
      expect(data).to have_key('updated_at')
    end
  end

  describe 'Relationship endpoints' do
    it 'should return items associated with a merchant' do
      create_list(:item, 5)

      get "/api/v1/merchants/#{Merchant.last.id}/items"

      data = JSON.parse(response.body)

      expect(data.length).to eq(1)
      expect(data.first["name"]).to eq("#{Item.last.name}")
      expect(data.first["unit_price"]).to eq(Item.last.unit_price)
      expect(data.first["description"]).to eq("#{Item.last.description}")
    end

    it 'should return invoices associated with a merchant' do
      create_list(:invoice, 5)

      get "/api/v1/merchants/#{Merchant.last.id}/invoices"

      data = JSON.parse(response.body)
      expect(data.first["status"]).to eq("#{Invoice.last.status}")
      expect(data.first["merchant_id"]).to eq(Invoice.last.merchant_id)
    end
  end
end
