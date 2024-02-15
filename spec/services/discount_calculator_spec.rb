# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product::DiscountCalculator do
  subject { described_class.new(product_type, quantity) }

  describe '#call' do
    context 'when MUG product type' do
      let(:product_type) { :mug }

      context 'when zero mugs' do
        let(:quantity) { 0 }

        it 'returns zero discount' do
          expect(subject.call).to eq 0.0
        end
      end

      context 'when quantity within discount range' do
        context do
          let(:quantity) { 15 }

          it 'returns expected discount' do
            expect(subject.call).to eq 0.02
          end
        end

        context do
          let(:quantity) { 37 }

          it 'returns expected discount' do
            expect(subject.call).to eq 0.06
          end
        end

        context do
          let(:quantity) { 93 }

          it 'returns expected discount' do
            expect(subject.call).to eq 0.18
          end
        end
      end

      context 'when quantity more than 150' do
        let(:quantity) { 200 }

        it 'returns expected discount' do
          expect(subject.call).to eq 0.3
        end
      end
    end

    context 'when T_SHIRT product type' do
      let(:product_type) { :t_shirt }

      context 'when quantity less than 3' do
        let(:quantity) { 2 }

        it 'returns expected discount' do
          expect(subject.call).to eq 0.0
        end
      end

      context 'when quantity more than 3' do
        let(:quantity) { 4 }

        it 'returns expected discount' do
          expect(subject.call).to eq 0.3
        end
      end

      context 'when quantity in 3' do
        let(:quantity) { 3 }

        it 'returns expected discount' do
          expect(subject.call).to eq 0.3
        end
      end
    end

    context 'when HOODIE product type' do
      let(:product_type) { :hoodie }
      let(:quantity) { 3 }

      it 'returns expected discount' do
        expect(subject.call).to eq 0.0
      end
    end

    context 'when unknown product type' do
      let(:product_type) { :unknown }
      let(:quantity) { 3 }

      it 'returns expected discount' do
        expect(subject.call).to eq 0.0
      end
    end
  end
end
