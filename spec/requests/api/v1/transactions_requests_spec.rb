require 'rails_helper'

RSpec.describe 'Transactions Requests' do
  before :each do
    @transactions = create_list(:transaction, 3)
  end

  describe 'All transactions' do
    it 'should return all transactions' do
      get '/api/v1/transactions.json'

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@transactions))
    end
  end

  describe 'A single transaction' do
    it 'should return a single transaction record found by its id' do
      get "/api/v1/transactions/#{@transactions[0].id}.json"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@transactions[0]))
    end
  end

  describe 'Single Finders' do
    it 'should be able to return an single record found by id' do
      get "/api/v1/transactions/find?id=#{@transactions[1].id}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@transactions[1]))
    end

    it 'should be able to return a single record found by credit card number' do
      get "/api/v1/transactions/find?credit_card_number=#{@transactions[0].credit_card_number}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@transactions[0]))
    end

    it 'should be able to return a single record found by result' do
      get "/api/v1/transactions/find?result=#{@transactions[0].result}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@transactions[0]))
    end
      
    it 'should be able to return an single record found by created date' do
      get "/api/v1/transactions/find?created_at=#{@transactions[0].created_at}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@transactions[0]))
    end

    it 'should be able to return an single record found by updated date' do
      get "/api/v1/transactions/find?updated_at=#{@transactions[0].updated_at}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@transactions[0]))
    end
  end
end
