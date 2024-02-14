# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product::TotalPrice do
  subject { described_class.new(products) }

  describe '#call' do
    let(:products) { { 'mug' => '15', 't_shirt' => '4', 'hoodie' => '2' } }

    it 'calls Product::DiscountCalculator with expected params' do
      expect(Product::DiscountCalculator).to receive(:new).with(:mug, 15).and_call_original
      expect(Product::DiscountCalculator).to receive(:new).with(:t_shirt, 4).and_call_original
      expect(Product::DiscountCalculator).to receive(:new).with(:hoodie, 2).and_call_original

      subject.call
    end

    context 'when performing calculations' do
      context 'when 1 MUG, 1 TSHIRT, 1 HOODIE' do
        let(:products) { { 'mug' => '1', 't_shirt' => '1', 'hoodie' => '1' } }

        it { expect(subject.call).to eq(41) }
      end

      context 'when 9 MUG, 1 TSHIRT' do
        let(:products) { { 'mug' => '9', 't_shirt' => '1' } }

        it { expect(subject.call).to eq(69) }
      end

      context 'when 10 MUG, 1 TSHIRT' do
        let(:products) { { 'mug' => '10', 't_shirt' => '1' } }

        it { expect(subject.call).to eq(73.80) }
      end

      context 'when 45 MUG, 3 TSHIRT' do
        let(:products) { { 'mug' => '45', 't_shirt' => '3' } }

        it { expect(subject.call).to eq(279.90) }
      end

      context 'when 200 MUG, 4 TSHIRT, 1 HOODIE' do
        let(:products) { { 'mug' => '200', 't_shirt' => '4', 'hoodie' => '1' } }

        it { expect(subject.call).to eq(902.00) }
      end
    end
  end
end
