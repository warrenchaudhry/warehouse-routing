class ProductRouteService

  attr_reader :reference

  def initialize(reference)
    @reference = reference
  end

  def ranked_definitions
    return {} unless matched_definitions.any?
    definitions = matched_definitions.group_by { |item| item.calculate_specificity(product) }
    Hash[ definitions.sort_by { |k,_| k }.reverse ]
  end

  def product
    @product ||= Product.find_by(reference: reference)
  end

  private

  def criteria_definitions
    return unless product

    @criteria_definitions ||= CriteriaDefinition.where(":reference = ANY(criteria_definitions.references)", reference: reference).
                              or(CriteriaDefinition.where(":category = ANY(criteria_definitions.categories)", category: product.category))
    @criteria_definitions = @criteria_definitions.where("max_product_price IS NULL OR max_product_price >= ?", product.price) if product.price
    @criteria_definitions
  end

  def matched_definitions
    return [] unless criteria_definitions
    definitions = []
    criteria_definitions.each do |definition|
      definition.permutations.each do |item|
        route_destination = CriteriaDefinitionService.new(definition.destination, item)
        definitions << route_destination if route_destination.match_product?(product)
      end
    end
    definitions.uniq
  end

end