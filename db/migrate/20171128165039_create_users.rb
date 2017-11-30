class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :role, default: "customer"
      t.boolean :instant_payment_allowed, default: false

      t.timestamps
    end
  end
end
