class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :brand
      t.string :model
      t.float :price
      t.integer :quantity_in_stock

      t.timestamps
    end
  end
end
