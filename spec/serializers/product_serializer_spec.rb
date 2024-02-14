# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductSerializer, type: :serializer do
  let(:serialized) { described_class.new(product).serializable_hash }
  let(:product) { create(:product, :mug) }

  it 'returns correct serialized response', :aggregate_failures do
    expect(serialized[:id]).to eq(product.id)
    expect(serialized[:code]).to eq(product.code)
    expect(serialized[:name]).to eq(product.name)
    expect(serialized[:product_type]).to eq(product.product_type)
    expect(serialized[:price_cents]).to eq(product.price_cents)
    expect(serialized[:price_currency]).to eq(product.price_currency)
    expect(serialized[:created_at]).to eq(product.created_at)
    expect(serialized[:updated_at]).to eq(product.updated_at)
  end
end
