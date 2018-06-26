require 'rails_helper'

RSpec.describe 'Merchants Endpoints' do
  before :all do
    @merchants = create_list(:merchant, 2)
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

      expect(data).to eq(json_with_soft_time(@merchants[1]))
    end

    it 'should be able to return a single record by its name' do
      get "/api/v1/merchants/find?name=#{@merchants[1].name}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@merchants[1]))
    end

    it 'should be able to return a single record by its created_at datetime' do
      early_merchant = Merchant.create!(name: 'Early Merchant', created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC')
      get "/api/v1/merchants/find?created_at=#{@merchants[0].created_at}"
      
      data = JSON.parse(response.body)
      
      expect(data).to eq(json_with_soft_time(@merchants[0]))
      expect(data).to_not eq(json_with_soft_time(early_merchant))
    end
    
    it 'should be able to return an single record by its updated_at datetime' do
      early_merchant = Merchant.create!(name: 'Early Merchant', created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC')

      get "/api/v1/merchants/find?updated_at=#{@merchants[0].updated_at}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@merchants[0]))
      expect(data).to_not eq(json_with_soft_time(early_merchant))
    end
  end

  describe 'Multiple Finders' do
    it 'should be able to return multiple records by id' do
      get "/api/v1/merchants/find_all?id=#{@merchants[0].id}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time([@merchants[0]]))
    end

    it 'should be able to return multiple records by name' do
      duplicate_merchant = Merchant.create!(name: 'Merchant 1')

      get "/api/v1/merchants/find_all?name=#{@merchants[0].name}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time([@merchants[0], duplicate_merchant]))
      expect(data).to_not eq(json_with_soft_time(@merchants[1]))
    end

    it 'sould be able to return multiple records by created_at' do
      early_merchant = Merchant.create!(name: 'Early Merchant', created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC')

      get "/api/v1/merchants/find_all?created_at=#{@merchants[0].created_at}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@merchants))
      expect(data).to_not eq(json_with_soft_time(early_merchant))
    end

    it 'sould be able to return multiple records by updated_at' do
      early_merchant = Merchant.create!(name: 'Early Merchant', created_at: '2012-03-27 14:53:59 UTC', updated_at: '2012-03-27 14:53:59 UTC')

      get "/api/v1/merchants/find_all?updated_at=#{@merchants[0].updated_at}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@merchants))
      expect(data).to_not eq(json_with_soft_time(early_merchant))
    end
  end

  describe 'Random Finder' do
    it 'should return a random record' do
      get '/api/v1/merchants/random.json'

      data = JSON.parse(response.body)

      expect(data.class).to eq(Hash)
      expect(data).to have_key('id')
      expect(data).to have_key('name')
      expect(data).to have_key('created_at')
      expect(data).to have_key('updated_at')
    end
  end
end
