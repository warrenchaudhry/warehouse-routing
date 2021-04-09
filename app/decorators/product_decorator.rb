class ProductDecorator < ApplicationDecorator
  delegate_all

  def price
    return '--' if object.price.blank?
    h.number_to_currency(object.price, precision: 2)
  end
end