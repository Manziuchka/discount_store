class CreatePriceRules < ActiveRecord::Migration[5.2]
  def change
    create_table :price_rules do |t|
      t.string :product_code
      t.string :discount_code
      t.float :percentage
      t.integer :min_amount

      t.timestamps
    end
  end
end
