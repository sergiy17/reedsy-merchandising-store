# frozen_string_literal: true

class Product < ApplicationRecord
  monetize :price_cents

  DEFAULT_PRICES = { mug: 6, t_shirt: 15, hoodie: 20 }.freeze

  enum product_type: { mug: 0, t_shirt: 1, hoodie: 2 }

  validates :code, :name, :product_type, presence: true
end
