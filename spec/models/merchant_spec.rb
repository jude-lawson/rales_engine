require 'rails_helper'

RSpec.describe Merchant do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'Class Methods' do
    describe '.search_result' do
      it 'should return a single record based on given key value pair' do
        merchant = Merchant.create!(name: 'Merchant 1')
        search_params = { name: 'Merchant 1'}
        expect(Merchant.search_result(search_params)).to eq(merchant)
      end
    end

    describe '.search_results' do
      it 'should return a collection of results based on provided search params' do
        merchant1 = Merchant.create!(name: 'Merchant 1')
        merchant2 = Merchant.create!(name: 'Merchant 2')

        search_params = { created_at: merchant1.created_at }
        expect(Merchant.search_results(search_params).length).to eq(2) 
      end
    end
  end
end
