require 'rails_helper'

RSpec.describe 'Merchants Endpoints' do
  before :each do
    @merchants = create_list(:merchant, 2)
  end

  describe 'Accesing the index endpoint' do
    it 'should return all merchant records' do
      get '/api/v1/merchants.json'

      data = JSON.parse(response.body)
      
      expect(response).to be_successful
      expect(data.length).to eq(2)
    end
  end
end
