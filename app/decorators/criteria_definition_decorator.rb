class CriteriaDefinitionDecorator < ApplicationDecorator
  delegate_all

  def references
    return '--' if object.references.empty?
    cnt = object.references.length
    arr = cnt > 3 ? object.references[0..2] : object.references
    str = arr.join(', ')
    str += '...' if cnt > 3
    str
  end

  def categories
    return '--' if object.categories.empty?
    cnt = object.categories.length
    arr = cnt > 3 ? object.categories[0..2] : object.categories
    str = arr.join(', ')
    str += '...' if cnt > 3
    str
  end

  def max_product_price
    return '--' if object.max_product_price.blank?
    h.number_to_currency(object.max_product_price, precision: 2)
  end
end