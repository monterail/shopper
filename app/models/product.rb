class Product < ApplicationRecord
  validates :brand, :model, :price, :quantity_in_stock, presence: true
  validates :price, :quantity_in_stock, numericality: { greater_than: 0 }

  def full_name
    "#{brand} #{model}"
  end
end
