require 'rails_helper'

RSpec.describe Transaction do
  describe 'Validations' do
    it { should validate_presence_of(:credit_card_number) }
    it { should validate_presence_of(:result) }
    # We could need this, but the CSV data is all empty right now
    # Awaiting clarification
    # it { should validate_presence_of(:credit_card_expiration_date) }
  end
end
