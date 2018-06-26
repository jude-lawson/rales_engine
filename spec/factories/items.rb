FactoryBot.define do
  factory :item do
    sequence :name do |n|
      "Banana #{n}"
    end
    description "MyText"
    unit_price 1
    merchant
  end
end
