class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.float :price
      t.integer :quantity
      t.float :total_price
      t.string :payment_status, default: "pending"

      t.timestamps
    end
  end
end
