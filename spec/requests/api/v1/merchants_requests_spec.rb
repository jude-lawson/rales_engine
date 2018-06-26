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
      get "/api/v1/merchants/find?created_at=#{@merchants[1].created_at}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@merchants[1]))
    end 
  end
end
