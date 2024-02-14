# frozen_string_literal: true

class Product::DiscountCalculator
  attr_accessor :product_type, :quantity

  def initialize(product_type, quantity)
    @product_type = product_type
    @quantity = quantity
  end

  def call
    case product_type
    when :mug
      quantity <= 150 ? (quantity / 10.round * 10 / 5).to_f / 100 : 0.3
      # quantity / 10.round * 10 -> for rounding the integer to the nearest lowest 10
    when :t_shirt
      quantity >= 3 ? 0.3 : 0
    when :hoodie
      0
    else
      0
    end
  end
end
