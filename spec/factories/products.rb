FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "PRODUCT_#{n}" }
    sequence(:reference) { |n| "REF_#{n}" }
    sequence(:category) { |n| "CATEGORY_#{n}" }
    price { 99 }
  end
end
