class CriteriaDefinition < ApplicationRecord

  before_validation :strip_and_convert_array_fields

  validate :check_required
  validates :destination, presence: true
  validates :max_product_price, numericality: true, allow_nil: true

  def permutations
    refs_arr = references.any? ? references : [nil]
    categories_arr = categories.any? ? categories : [nil]
    price = [max_product_price]
    refs_arr.product(categories_arr, price)
  end

  private

  def strip_and_convert_array_fields
    %i[references categories].each do |attr|
      if self[attr].present?
        value = self[attr].map(&:strip).reject(&:blank?)
        self[attr] = value.blank? ? nil : value.sort
      end
    end
  end

  def check_required
    return unless references.blank? && categories.blank? && max_product_price.blank?
    errors.add(:base, "Please add either one of the criteria: references, categories or max_product_price")
  end
end
