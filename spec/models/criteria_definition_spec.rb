require 'rails_helper'

RSpec.describe CriteriaDefinition, type: :model do
  let(:criteria_definition) { build(:criteria_definition, references: nil, categories: nil, max_product_price: nil, destination: 'DESTINATION_1') }
  subject { criteria_definition }

  describe '#validations' do
    it { should validate_presence_of(:destination) }
    it { should validate_numericality_of(:max_product_price) }
    it 'is not valid if all criteria are blank' do
      expect(subject).not_to be_valid
    end
  end
end
