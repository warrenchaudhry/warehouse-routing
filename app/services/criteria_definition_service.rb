class CriteriaDefinitionService

  attr_reader :reference, :category, :max_price, :destination

  def initialize(destination, criteria = [])
    @destination = destination
    @reference, @category, @max_price = criteria
  end

  def to_s
    [reference, category, max_price, destination].
      reduce([]) { |str, elem| str << (elem.blank? ? '_' : elem) }.
      join(', ')
  end

  def calculate_specificity(product)
    rank = 0
    rank += 1 if product.reference == reference
    rank += 1 if product.category == category
    rank += 1 if product.price.to_d <= max_price.to_d
    rank
  end

  def match_product?(product)
    x = (reference == product.reference) || (category == product.category)
    x &= product.price.to_d <= max_price if max_price
    x
  end
end
