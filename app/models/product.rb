# frozen_string_literal: true

class Product < ApplicationRecord
  monetize :price_cents

  enum product_type: { mug: 0, t_shirt: 1, hoodie: 2 }

  validates :code, :name, :product_type, presence: true
end
