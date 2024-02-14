# frozen_string_literal: true

class Product::TotalPrice
  attr_accessor :products

  def initialize(products)
    @products = products.symbolize_keys.transform_values(&:to_i)
  end

  def call
    products.sum do |product_type, amount|
      product_price = Product::DEFAULT_PRICES[product_type].to_f
      total_products_price = product_price * amount
      discount_amount = total_products_price * discounted_percent(product_type, amount)

      total_products_price - discount_amount
    end
  end

  def discounted_percent(product_type, amount)
    Product::DiscountCalculator.new(product_type, amount).call
  end
end
