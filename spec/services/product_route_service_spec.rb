require "rails_helper"

RSpec.describe ProductRouteService do
  let!(:criteria_1) {
    create(:criteria_definition, references: %w[REF_1 REF_2], categories: %w[CATEGORY_1 CATEGORY_3], max_product_price: 100, destination: 'DESTINATION_1')
  }
  let!(:criteria_2) {
    create(:criteria_definition, references: %w[REF_3], categories: %w[CATEGORY_2 CATEGORY_3], max_product_price: nil, destination: 'DESTINATION_2')
  }
  let!(:product_1) {
    create(:product, reference: 'REF_1', category: 'CATEGORY_1', price: nil)
  }
  let!(:product_2) {
    create(:product, reference: 'REF_2', category: 'CATEGORY_3', price: 100)
  }
  let!(:product_3) {
    create(:product, reference: 'REF_3', category: 'CATEGORY_2', price: 100)
  }
  let!(:product_4) {
    create(:product, reference: 'REF_4', category: 'CATEGORY_4')
  }
  describe "#ranked_definitions" do
    subject(:product_route) { described_class.new(product_1.reference) }
    context "with a matching criteria definitions" do
      it "returns list of definitions with priority" do
        definitions = product_route.ranked_definitions
        expect(definitions.keys).to eq([3,2])
        expect(definitions.values.flatten.collect(&:to_s)).to eq([
                                    "REF_1, CATEGORY_1, 100.0, DESTINATION_1",
                                    "REF_1, CATEGORY_3, 100.0, DESTINATION_1",
                                    "REF_2, CATEGORY_1, 100.0, DESTINATION_1"
                                  ])
      end
    end

    context "without matched criteria definitions" do
      subject(:product_route) { described_class.new(product_4.reference) }
      it "returns an empty hash" do
        expect(product_route.ranked_definitions).to eq({})
      end
    end

    context "when criteria_definitions matches the product's category but not the reference" do
      it "returns list of matched definitions" do
        product_4.update(category: 'CATEGORY_1')
        product_route = described_class.new(product_4.reference)
        definitions = product_route.ranked_definitions
        expect(definitions.keys).to eq([2])
        expect(definitions.values.flatten.collect(&:to_s)).to eq([
                                                                   "REF_1, CATEGORY_1, 100.0, DESTINATION_1",
                                                                   "REF_2, CATEGORY_1, 100.0, DESTINATION_1"
                                                                 ])
      end
    end
  end
end
