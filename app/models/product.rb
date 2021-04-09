class Product < ApplicationRecord
  validates :name, :reference, :category, presence: true
  validates :reference, uniqueness: true, allow_blank: true
  validates :price, numericality: true, allow_nil: true
end
