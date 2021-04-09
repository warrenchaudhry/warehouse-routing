FactoryBot.define do
  factory :criteria_definition do
    references { ['REF_1'] }
    categories { ['CATEGORY_1'] }
    max_product_price { nil }
    destination { 'DESTINATION_1' }
  end
end
