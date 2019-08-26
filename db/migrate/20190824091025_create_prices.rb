class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.string :product_code
      t.string :name
      t.float :cost

      t.timestamps
    end
  end
end
