require "rails_helper"

RSpec.describe CriteriaDefinitionService do
  let!(:criteria) {
    create(:criteria_definition,
      references: %w[REF_1 REF_2],
      categories: %w[CATEGORY_1 CATEGORY_3],
      max_product_price: 100,
      destination: 'DESTINATION_1'
    )
  }
  let!(:product) {
    create(:product, reference: 'REF_1', category: 'CATEGORY_1', price: nil)
  }
  let(:criteria_args) { [product.reference, product.category, criteria.max_product_price] }
  subject(:criteria_definition_service) { described_class.new(criteria.destination, criteria_args) }

  describe "#calculate_specificity" do
    it 'will return the sum of the matches' do
      expect(criteria_definition_service.calculate_specificity(product)).to eq(3)
    end
  end

  describe "#match_product?" do
    context 'when comparing the product values against the criteria'  do
      it 'returns true if it matches reference or category and price' do
        expect(criteria_definition_service.match_product?(product)).to be_truthy
      end

      it 'returns false if doesn\'t match the reference and category' do
        args = ['REF_3', 'CATEGORY_3', nil]
        criteria_definition_service = CriteriaDefinitionService.new(criteria.destination, args)
        expect(criteria_definition_service.match_product?(product)).to be_falsy
      end

      it 'returns false product\'s price is greater than max_product_price' do
        @product = create(:product, reference: 'REF_2', category: 'CATEGORY_3', price: 150)
        args = ['REF_1', 'CATEGORY_1', 100]
        criteria_definition_service = CriteriaDefinitionService.new(criteria.destination, args)
        expect(criteria_definition_service.match_product?(@product)).to be_falsy
      end
    end
  end
end
