class PriceRule < ApplicationRecord
  validates :product_code, presence: true, uniqueness: true
  validates :product_code, length: { is: 2 }
end
