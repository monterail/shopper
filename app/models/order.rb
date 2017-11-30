class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user

  before_save :set_fields

  validates :user, :product, :quantity, :total_price, :payment_status, presence: true
  validates :quantity, :total_price, numericality: { greater_than: 0 }
  validate :product_is_available

  private

  def set_fields
    self.price = product.price
    if user.instant_payment_allowed
      self.payment_status = "processed"
    else
      self.payment_status = "pending"
    end
  end

  def product_is_available
    if product.quantity_in_stock < quantity
      errors.add(:product_amount, "can't be greater than #{product.quantity_in_stock}")
    end
  end
end
