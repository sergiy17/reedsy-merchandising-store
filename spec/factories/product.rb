# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    trait :mug do
      code { 'MUG' }
      name { 'Reedsy Mug' }
      product_type { 'mug' }
      price_cents { 6_00 }
    end

    trait :t_shirt do
      code { 'TSHIRT' }
      name { 'Reedsy T-shirt' }
      product_type { 't_shirt' }
      price_cents { 15_00 }
    end

    trait :hoodie do
      code { 'HOODIE' }
      name { 'Reedsy Hoodie' }
      product_type { 'hoodie' }
      price_cents { 20_00 }
    end
  end
end