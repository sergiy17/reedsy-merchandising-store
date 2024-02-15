# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  subject(:perform_request) { request }
  let(:parsed_body) { JSON.parse(response.body) }

  describe "GET 'index'" do
    let(:request) { get :index }

    before do
      create_list(:product, 2, :mug)
      create_list(:product, 2, :t_shirt)
      create_list(:product, 2, :hoodie)

      perform_request
    end

    it 'returns serialized products' do
      expect(parsed_body.pluck('id')).to match_array(Product.all.ids)
    end
  end

  describe "PUT 'update'" do
    let(:target_product) { create(:product, :mug) }
    let(:request) { post :update,  params: }

    context 'when successfully updates the product' do
      let(:params) { { id: target_product.id, price_cents: 10_00 } }

      it 'returns updated product' do
        expect(target_product.price_cents).to eq(6_00)

        perform_request

        expect(target_product.reload.price_cents).to eq(10_00)
      end
    end

    context 'when product not found' do
      let(:params) { { id: -1, price_cents: 10_00 } }

      before { perform_request }

      it { expect(response).to have_http_status(:not_found) }

      it 'returns correct error message' do
        expect(parsed_body['error']).to eq('Product not found')
      end
    end

    context 'when error occurs while updating' do
      let!(:target_product) { create(:product, :mug) }
      let(:params) { { id: target_product.id } }

      it 'returns 422 status' do
        allow_any_instance_of(Product).to receive(:valid?).and_return(false)

        perform_request

        expect(response).to have_http_status(422)
      end
    end
  end

  describe "GET 'total_price'" do
    let(:request) { post :total_price, params: }
    let(:params) { { mug: 2, t_shirt: 4, hoodie: 1 } }

    before { perform_request }

    context 'when 9 MUG, 1 TSHIRT' do
      let(:params) { { mug: 9, t_shirt: 1 } }

      it { expect(parsed_body['total']).to eq(69) }
    end
  end
end
