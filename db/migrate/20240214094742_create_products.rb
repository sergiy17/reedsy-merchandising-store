# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :code
      t.string :name
      t.integer :product_type
      t.monetize :price, amount: { null: false, default: 0 },
                         currency: { null: false, default: MoneyRails.default_currency.to_s }

      t.timestamps
    end
  end
end
