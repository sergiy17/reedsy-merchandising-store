# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :load_product, only: %i[update]

  def index
    products = Product.all
    render json: products, each_serializer: ProductSerializer
  end

  def update
    return render json: { error: 'Product not found' }, status: :not_found unless @product

    if @product.update(update_params)
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  private

  def update_params
    params.permit(:price_cents, :price_currency)
  end

  def load_product
    @product = Product.find_by(id: params[:id])
  end
end
