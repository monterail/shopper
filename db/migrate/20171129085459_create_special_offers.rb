class CreateSpecialOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :special_offers do |t|
      t.integer :discount
      t.datetime :date_from
      t.datetime :date_to

      t.timestamps
    end
  end
end
