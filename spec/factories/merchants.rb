FactoryBot.define do
  factory :merchant do
    sequence(:name) { |num| "Merchant #{num}" }
  end
end
