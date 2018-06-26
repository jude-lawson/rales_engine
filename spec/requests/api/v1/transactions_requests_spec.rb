require 'rails_helper'

RSpec.describe 'Transactions Requests' do
  before :all do
    @date = "2018-06-26T21:25:04.512Z"
    customer1 = Customer.create!(first_name: "Bob", last_name: "Smith", created_at: @date, updated_at: @date)
    merchant1 = Merchant.create(name: "Merchant", created_at: @date, updated_at: @date)
    invoice = Invoice.create!(customer_id: customer1.id, merchant_id: merchant1.id, status: "success")
    transaction1 = Transaction.create!(invoice_id: invoice.id, credit_card_number: 1234567812341234, credit_card_expiration_date: "", result: "success", created_at: @date, updated_at: @date)
    transaction2 = Transaction.create!(invoice_id: invoice.id, credit_card_number: 1234567812341234, credit_card_expiration_date: "", result: "success", created_at: @date, updated_at: @date)
    transaction3 = Transaction.create!(invoice_id: invoice.id, credit_card_number: 1234567812341234, credit_card_expiration_date: "", result: "success", created_at: @date, updated_at: @date)
    @transactions = [transaction1, transaction2, transaction3]
  end

  describe 'All transactions' do
    it 'should return all transactions' do
      get '/api/v1/transactions.json'

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@transactions))
    end
  end

  describe 'A single transaction' do
    it 'should return a single transaction record found by its id' do
      get "/api/v1/transactions/#{@transactions[0].id}.json"

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@transactions[0]))
    end
  end

  describe 'Single Finders' do
    it 'should be able to return an single record found by id' do
      get "/api/v1/transactions/find?id=#{@transactions[1].id}"

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@transactions[1]))
    end

    it 'should be able to return a single record found by credit card number' do
      get "/api/v1/transactions/find?credit_card_number=#{@transactions[0].credit_card_number}"

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@transactions[0]))
    end

    it 'should be able to return a single record found by result' do
      get "/api/v1/transactions/find?result=#{@transactions[0].result}"

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@transactions[0]))
    end
      
    it 'should be able to return an single record found by created date' do
      get "/api/v1/transactions/find?created_at=#{@date}"

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@transactions[0]))
    end

    it 'should be able to return an single record found by updated date' do
      get "/api/v1/transactions/find?updated_at=#{@date}"

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@transactions[0]))
    end
  end

  describe 'Multi Finders' do
    it 'should be able to return a collection using id' do
      get "/api/v1/transactions/find_all?id=#{@transactions[0].id}"

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time([@transactions[0]]))
      expect(data).to_not eq(json_with_soft_time([@transactions[1]]))
    end

    it 'should be able to return a collection using credit_card_number' do
      sad_transaction = create(:transaction, credit_card_number: 9876876576546543)
      get "/api/v1/transactions/find_all?credit_card_number=#{@transactions[0].credit_card_number}"
      
      data = JSON.parse(response.body)
      
      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@transactions))
      expect(data).to_not eq(json_with_soft_time(sad_transaction))
    end
    
    it 'should be able to return a collection using result' do
      sad_transaction = create(:transaction, result: 'failed')
      get "/api/v1/transactions/find_all?result=#{@transactions[0].result}"
      
      data = JSON.parse(response.body)
      
      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@transactions))
      expect(data).to_not eq(json_with_soft_time(sad_transaction))
    end
    
    it 'should be able to return a collection using created_at' do
      sad_transaction = create(:transaction, created_at: Date.yesterday)
      get "/api/v1/transactions/find_all?created_at=#{@date}"
      
      data = JSON.parse(response.body)
      
      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@transactions))
      expect(data).to_not eq(json_with_soft_time(sad_transaction))
    end
    
    it 'should be able to return a collection using updated_at' do
      sad_transaction = create(:transaction, updated_at: Date.yesterday)
      get "/api/v1/transactions/find_all?updated_at=#{@date}"

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@transactions))
      expect(data).to_not eq(json_with_soft_time(sad_transaction))
    end
  end

  describe 'Random Finder' do
    it 'should be able to return a random record' do
      get '/api/v1/transactions/random.json'

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data.class).to eq(Hash)
      expect(data).to have_key('id')
      expect(data).to have_key('invoice_id')
      expect(data).to have_key('credit_card_number')
      expect(data).to have_key('credit_card_expiration_date')
      expect(data).to have_key('result')
      expect(data).to have_key('created_at')
      expect(data).to have_key('updated_at')
    end
  end

  describe 'Relationship endpoint' do
    it 'should return associated invoice' do
      create_list(:transaction, 4)

      get "/api/v1/transactions/#{Transaction.last.id}/invoice"

      data = JSON.parse(response.body)
      expect(data["status"]).to eq("#{Invoice.last.status}")
      expect(data["customer_id"]).to eq(Invoice.last.customer_id)
    end
  end
end
