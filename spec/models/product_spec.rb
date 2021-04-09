require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:reference) }
    it { should validate_presence_of(:category) }
    it { should validate_uniqueness_of(:reference) }
    it { should validate_numericality_of(:price) }
  end
end
