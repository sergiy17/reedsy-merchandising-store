# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :product_type, :price_cents, :price_currency, :created_at, :updated_at
end
