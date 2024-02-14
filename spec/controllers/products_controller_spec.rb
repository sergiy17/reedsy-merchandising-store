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
end
