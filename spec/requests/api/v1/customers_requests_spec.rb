require 'rails_helper'

RSpec.describe 'Customers Requests' do
  before :each do
    @date = "2018-06-26T21:25:04.512Z"
    customer1 = Customer.create!(first_name: "Bob", last_name: "Smith", created_at: @date, updated_at: @date)
    customer2 = Customer.create!(first_name: "Bob", last_name: "Smith", created_at: @date, updated_at: @date)
    customer3 = Customer.create!(first_name: "Bob", last_name: "Smith", created_at: @date, updated_at: @date)
    @customers = [customer1, customer2, customer3]
  end
  describe 'All customer records' do
    it 'should be able to return all customer records' do
      get '/api/v1/customers.json'

      data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(data).to eq(json_with_soft_time(@customers))
    end
  end

  describe 'A single customer record' do
    it 'should be able to return a single customer record' do
      get "/api/v1/customers/#{@customers[0].id}.json"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@customers[0]))
    end
  end

  describe 'Single Finders' do
    it 'should be able to return a single record by id' do
      get "/api/v1/customers/find?id=#{@customers[0].id}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@customers[0]))
    end

    it 'should be able to return a single record by first name' do
      get "/api/v1/customers/find?first_name=#{@customers[0].first_name}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@customers[0]))
    end

    it 'should be able to return a single record by last name' do
      get "/api/v1/customers/find?last_name=#{@customers[0].last_name}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@customers[0]))
    end

    it 'should be able to return a single record by created date' do
      get "/api/v1/customers/find?created_at=#{@date}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@customers[0]))
    end

    it 'should be able to return a single record by updated date' do
      get "/api/v1/customers/find?updated_at=#{@date}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@customers[0]))
    end
  end

  describe 'Multi Finders' do
    it 'should be able to return a collection of transactions from id' do
      get "/api/v1/customers/find_all?id=#{@customers[0].id}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time([@customers[0]]))
      expect(data).to_not eq(json_with_soft_time([@customers[2]]))
    end

    it 'should be able to return a collection of transactions from first name' do
      sad_customer = Customer.create!(first_name: 'Sad', last_name: 'Customer')
      get "/api/v1/customers/find_all?first_name=#{@customers[0].first_name}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@customers))
      expect(data).to_not eq(json_with_soft_time([sad_customer]))
    end

    it 'should be able to return a collection of transactions from last name' do
      sad_customer = Customer.create!(first_name: 'Sad', last_name: 'Customer')
      get "/api/v1/customers/find_all?last_name=#{@customers[0].last_name}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@customers))
      expect(data).to_not eq(json_with_soft_time([sad_customer]))
    end

    it 'should be able to return a collection of transactions from created date' do
      sad_customer = create(:customer, created_at: Date.yesterday)
      get "/api/v1/customers/find_all?created_at=#{@date}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@customers))
      expect(data).to_not eq(json_with_soft_time([sad_customer]))
    end

    it 'should be able to return a collection of transactions from update date' do
      sad_customer = create(:customer, updated_at: Date.yesterday)
      get "/api/v1/customers/find_all?updated_at=#{@date}"

      data = JSON.parse(response.body)

      expect(data).to eq(json_with_soft_time(@customers))
      expect(data).to_not eq(json_with_soft_time([sad_customer]))
    end
  end

  describe 'Random Finders' do
    it 'should return a random record' do
      get '/api/v1/customers/random.json'

      data = JSON.parse(response.body)

      expect(data.class).to eq(Hash)
      expect(data).to have_key('first_name')
      expect(data).to have_key('last_name')
      expect(data).to have_key('created_at')
      expect(data).to have_key('updated_at')
    end
  end
end
