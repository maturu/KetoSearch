class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.integer :price_id
      t.string :name
      t.integer :twenty_nineteen_feb
      t.integer :twenty_nineteen_mar
      t.integer :twenty_nineteen_apr
      t.integer :twenty_nineteen_may
      t.integer :twenty_nineteen_jun
      t.integer :twenty_nineteen_jul
      t.integer :twenty_nineteen_aug
      t.integer :twenty_nineteen_sep
      t.integer :twenty_nineteen_oct
      t.integer :twenty_nineteen_nov
      t.integer :twenty_nineteen_dec
      t.integer :twenty_twenty_jan
      t.integer :twenty_twenty_feb

      t.timestamps
    end
  end
end
